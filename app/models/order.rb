class Order < ApplicationRecord
  belongs_to :user
  belongs_to :producer
  belongs_to :product
  belongs_to :order_group, optional: true # Optionnel pour compatibilité avec les anciennes commandes

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :platform_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :producer_amount, presence: true, numericality: { greater_than: 0 }
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

  def cancelled?
    status == "cancelled"
  end

  # Format amounts for display
  def formatted_total
    "€#{format('%.2f', total_amount)}"
  end

  def formatted_platform_fee
    "€#{format('%.2f', platform_fee)}"
  end

  def formatted_producer_amount
    "€#{format('%.2f', producer_amount)}"
  end

  # Calculate amounts (platform takes 10% commission)
  def self.calculate_amounts(total_amount, platform_fee_percentage = 10)
    platform_fee = (total_amount * platform_fee_percentage / 100.0).round(2)
    producer_amount = (total_amount - platform_fee).round(2)

    {
      total_amount: total_amount,
      platform_fee: platform_fee,
      producer_amount: producer_amount
    }
  end
end
