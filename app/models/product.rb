class Product < ApplicationRecord
  belongs_to :producer
  has_many :orders, dependent: :restrict_with_error
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :available, -> { where("stock > ?", 0) }
  scope :recent, -> { order(created_at: :desc) }

  # Check if product is available
  def available?
    stock > 0
  end

  # Calculate price in cents for Stripe
  def price_in_cents
    (price * 100).to_i
  end

  # Format price for display
  def formatted_price
    "€#{format('%.2f', price)}"
  end

  # Reduce stock when order is placed
  def reduce_stock!(quantity)
    update!(stock: stock - quantity)
  end
end
