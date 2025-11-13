class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [ :new, :create ]
  before_action :set_order, only: [ :show, :payment ]

  def index
    @orders = current_user.orders.includes(:product, :producer).recent
  end

  def show
  end

  def new
    unless @product.available?
      redirect_to @product, alert: "Product is out of stock"
      return
    end

    unless @product.producer.can_receive_payments?
      redirect_to @product, alert: "Producer cannot receive payments yet"
      return
    end

    @order = Order.new(
      product: @product,
      producer: @product.producer,
      quantity: 1
    )
  end

  def create
    unless @product.available?
      redirect_to @product, alert: "Product is out of stock"
      return
    end

    unless @product.producer.can_receive_payments?
      redirect_to @product, alert: "Producer cannot receive payments yet"
      return
    end

    quantity = order_params[:quantity].to_i

    if quantity > @product.stock
      redirect_to @product, alert: "Not enough stock available"
      return
    end

    # Calculate amounts
    total = (@product.price * quantity).round(2)
    amounts = StripePaymentService.calculate_split(total)

    @order = current_user.orders.build(
      product: @product,
      producer: @product.producer,
      quantity: quantity,
      total_amount: amounts[:total_amount],
      platform_fee: amounts[:platform_fee],
      producer_amount: amounts[:producer_amount],
      status: "pending"
    )

    if @order.save
      redirect_to payment_order_path(@order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def payment
    redirect_to root_path, alert: "Access denied" unless @order.user == current_user

    if @order.paid? || @order.completed?
      redirect_to @order, notice: "This order has already been paid"
      return
    end

    begin
      @payment_intent = StripePaymentService.create_payment_intent(@order)
      @stripe_publishable_key = Rails.configuration.stripe[:publishable_key]
    rescue => e
      redirect_to @order, alert: "Failed to create payment: #{e.message}"
    end
  end

  def confirm_payment
    @order = Order.find(params[:id])
    redirect_to root_path, alert: "Access denied" unless @order.user == current_user

    payment_intent = StripePaymentService.retrieve_payment_intent(@order.stripe_payment_intent_id)

    if payment_intent.status == "succeeded"
      @order.update!(status: "paid")
      @order.product.reduce_stock!(@order.quantity)
      redirect_to @order, notice: "Payment successful!"
    else
      redirect_to payment_order_path(@order), alert: "Payment not completed yet"
    end
  rescue => e
    redirect_to payment_order_path(@order), alert: "Error checking payment: #{e.message}"
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:quantity)
  end
end
