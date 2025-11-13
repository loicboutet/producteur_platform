class StripeConnectService
  # Create a Stripe Connect account for a producer
  def self.create_account(producer)
    account = Stripe::Account.create({
      type: "express",
      country: "FR",
      email: producer.email,
      capabilities: {
        card_payments: { requested: true },
        transfers: { requested: true }
      },
      business_type: "individual",
      metadata: {
        producer_id: producer.id
      }
    })

    producer.update!(
      stripe_account_id: account.id,
      stripe_account_status: "pending"
    )

    account
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to create Stripe account: #{e.message}"
    raise
  end

  # Generate account link for onboarding
  def self.create_account_link(producer, refresh_url:, return_url:)
    raise ArgumentError, "Producer must have a Stripe account" unless producer.stripe_account_id

    Stripe::AccountLink.create({
      account: producer.stripe_account_id,
      refresh_url: refresh_url,
      return_url: return_url,
      type: "account_onboarding"
    })
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to create account link: #{e.message}"
    raise
  end

  # Create a login link for existing accounts
  def self.create_login_link(producer)
    raise ArgumentError, "Producer must have a Stripe account" unless producer.stripe_account_id

    Stripe::Account.create_login_link(producer.stripe_account_id)
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to create login link: #{e.message}"
    raise
  end

  # Check and update account status
  def self.update_account_status(producer)
    return unless producer.stripe_account_id

    account = Stripe::Account.retrieve(producer.stripe_account_id)

    status = if account.charges_enabled && account.payouts_enabled
      "active"
    elsif account.requirements&.disabled_reason
      "restricted"
    else
      "pending"
    end

    producer.update!(stripe_account_status: status)
    status
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to update account status: #{e.message}"
    nil
  end
end
