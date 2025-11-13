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

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
  secret_key: Rails.application.credentials.dig(:stripe, :secret_key),
  webhook_secret: Rails.application.credentials.dig(:stripe, :webhook_secret)
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
