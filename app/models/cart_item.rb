class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :product_has_stock

  # Sous-total de cet article
  def subtotal
    product.price * quantity
  end

  # Commission pour cet article
  def platform_fee
    (subtotal * 0.10).round(2)
  end

  # Montant pour le producteur
  def producer_amount
    (subtotal - platform_fee).round(2)
  end

  private

  def product_has_stock
    return unless product

    if quantity > product.stock
      errors.add(:quantity, "exceeds available stock (#{product.stock} available)")
    end
  end
end
