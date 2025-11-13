class Producer < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :stripe_account_status, inclusion: { in: %w[pending active restricted] }

  # Scopes
  scope :active, -> { where(stripe_account_status: "active") }
  scope :pending, -> { where(stripe_account_status: "pending") }

  # Check if the producer can receive payments
  def can_receive_payments?
    stripe_account_id.present? && stripe_account_status == "active"
  end

  # Get the Stripe account details
  def stripe_account
    return nil unless stripe_account_id

    @stripe_account ||= Stripe::Account.retrieve(stripe_account_id)
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to retrieve Stripe account: #{e.message}"
    nil
  end

  # Check charges enabled status from Stripe
  def charges_enabled?
    stripe_account&.charges_enabled || false
  end

  # Check payouts enabled status from Stripe
  def payouts_enabled?
    stripe_account&.payouts_enabled || false
  end
end
