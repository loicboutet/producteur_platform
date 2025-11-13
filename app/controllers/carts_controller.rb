class CartsController < ApplicationController
  before_action :set_cart

  def show
    @items_by_producer = @cart.items_by_producer
    @producer_amounts = @cart.producer_amounts
  end

  def add_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity]&.to_i || 1

    unless product.available?
      redirect_to product, alert: "Product is out of stock"
      return
    end

    if quantity > product.stock
      redirect_to product, alert: "Not enough stock available (#{product.stock} available)"
      return
    end

    @cart.add_product(product, quantity)
    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

  def update_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    @cart.update_quantity(product, quantity)

    if quantity > 0
      redirect_to cart_path, notice: "Cart updated"
    else
      redirect_to cart_path, notice: "Item removed from cart"
    end
  end

  def remove_item
    product = Product.find(params[:product_id])
    @cart.remove_product(product)
    redirect_to cart_path, notice: "Item removed from cart"
  end

  def clear
    @cart.clear
    redirect_to cart_path, notice: "Cart cleared"
  end

  private

  def set_cart
    # Utiliser l'ID de session Rails pour identifier le panier
    session_id = session.id.to_s
    @cart = Cart.for_session(session_id, current_user)
  end
end
