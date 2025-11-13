class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    if @cart.empty?
      redirect_to cart_path, alert: "Your cart is empty"
      return
    end

    # Vérifier que tous les producteurs peuvent recevoir des paiements
    @cart.producers.each do |producer|
      unless producer.can_receive_payments?
        redirect_to cart_path, alert: "Producer #{producer.name} cannot receive payments yet. Please remove their products from your cart."
        return
      end
    end

    @items_by_producer = @cart.items_by_producer
    @producer_amounts = @cart.producer_amounts
  end

  def create
    if @cart.empty?
      redirect_to cart_path, alert: "Your cart is empty"
      return
    end

    # Vérifier le stock pour chaque produit
    @cart.cart_items.each do |item|
      if item.quantity > item.product.stock
        redirect_to cart_path, alert: "Not enough stock for #{item.product.name}"
        return
      end
    end

    # Créer le groupe de commandes
    @order_group = OrderGroup.create_from_cart(@cart, current_user)

    if @order_group
      redirect_to payment_checkout_path
    else
      redirect_to cart_path, alert: "Failed to create order"
    end
  end

  def payment
    @order_group = current_user.order_groups.pending.order(created_at: :desc).first

    unless @order_group
      redirect_to cart_path, alert: "No pending order found"
      return
    end

    begin
      @payment_intent = StripeMultiTransferService.create_payment_intent(@order_group)
      @stripe_publishable_key = Rails.configuration.stripe[:publishable_key]
    rescue => e
      redirect_to cart_path, alert: "Failed to create payment: #{e.message}"
    end
  end

  def confirm_payment
    @order_group = current_user.order_groups.find(params[:order_group_id])

    payment_intent = StripeMultiTransferService.retrieve_payment_intent(@order_group.stripe_payment_intent_id)

    if payment_intent.status == "succeeded"
      # Le webhook s'occupera de créer les transfers
      # Mais on peut aussi le faire ici de manière synchrone
      unless @order_group.paid?
        StripeMultiTransferService.handle_payment_success(payment_intent)
      end

      # Vider le panier
      @cart.clear

      redirect_to order_group_path(@order_group), notice: "Payment successful!"
    else
      redirect_to payment_checkout_path, alert: "Payment not completed yet"
    end
  rescue => e
    redirect_to payment_checkout_path, alert: "Error checking payment: #{e.message}"
  end

  private

  def set_cart
    session_id = session.id.to_s
    @cart = Cart.for_session(session_id, current_user)
  end
end
