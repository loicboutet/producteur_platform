# Stripe configuration
# Store your Stripe keys in Rails credentials
# 
# To edit credentials:
#   bin/rails credentials:edit
# 
# Add this structure:
#   stripe:
#     publishable_key: pk_test_your_key_here
#     secret_key: sk_test_your_key_here
#     webhook_secret: whsec_your_webhook_secret_here (optional)

stripe_config = begin
  {
    publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
    secret_key: Rails.application.credentials.dig(:stripe, :secret_key),
    webhook_secret: Rails.application.credentials.dig(:stripe, :webhook_secret)
  }
rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
  Rails.logger.warn "⚠️  Could not decrypt credentials: #{e.message}"
  Rails.logger.warn "⚠️  Stripe will not be configured. Please fix your master.key or regenerate credentials."
  {
    publishable_key: nil,
    secret_key: nil,
    webhook_secret: nil
  }
end

Rails.configuration.stripe = stripe_config
Stripe.api_key = Rails.configuration.stripe[:secret_key] if Rails.configuration.stripe[:secret_key].present?
