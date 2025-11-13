class OrderGroup < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :platform_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid processing completed cancelled refunded] }

  # Scopes
  scope :pending, -> { where(status: "pending") }
  scope :paid, -> { where(status: "paid") }
  scope :completed, -> { where(status: "completed") }
  scope :recent, -> { order(created_at: :desc) }

  # Status checks
  def pending?
    status == "pending"
  end

  def paid?
    status == "paid"
  end

  def completed?
    status == "completed"
  end

  # Format amounts
  def formatted_total
    "€#{format('%.2f', total_amount)}"
  end

  def formatted_platform_fee
    "€#{format('%.2f', platform_fee)}"
  end

  # Nombre de producteurs différents
  def producers_count
    orders.joins(:producer).select(:producer_id).distinct.count
  end

  # Liste des producteurs
  def producers
    Producer.joins(:orders).where(orders: { order_group_id: id }).distinct
  end

  # Créer à partir d'un panier
  def self.create_from_cart(cart, user)
    return nil if cart.empty?

    transaction do
      # Créer le groupe de commandes
      order_group = create!(
        user: user,
        total_amount: cart.total,
        platform_fee: cart.total_platform_fee,
        status: "pending"
      )

      # Créer une commande par producteur
      cart.items_by_producer.each do |producer, items|
        items.each do |cart_item|
          product = cart_item.product
          quantity = cart_item.quantity

          # Calculer les montants pour ce produit
          subtotal = product.price * quantity
          amounts = Order.calculate_amounts(subtotal)

          order_group.orders.create!(
            user: user,
            producer: producer,
            product: product,
            quantity: quantity,
            total_amount: amounts[:total_amount],
            platform_fee: amounts[:platform_fee],
            producer_amount: amounts[:producer_amount],
            status: "pending"
          )
        end
      end

      order_group
    end
  end
end
