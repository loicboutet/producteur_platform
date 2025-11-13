class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.configuration.stripe[:webhook_secret]

    begin
      if endpoint_secret.present?
        # Verify webhook signature for security
        event = Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
        )
      else
        # For testing without webhook secret (not recommended for production)
        Rails.logger.warn "Stripe webhook signature verification disabled"
        event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
      end
    rescue JSON::ParserError => e
      Rails.logger.error "Stripe webhook error: Invalid payload - #{e.message}"
      render json: { error: "Invalid payload" }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "Stripe webhook error: Invalid signature - #{e.message}"
      render json: { error: "Invalid signature" }, status: :bad_request
      return
    end

    # Handle the event
    case event.type
    when "payment_intent.succeeded"
      handle_payment_success(event.data.object)
    when "payment_intent.payment_failed"
      handle_payment_failure(event.data.object)
    when "account.updated"
      handle_account_updated(event.data.object)
    else
      Rails.logger.info "Unhandled Stripe event type: #{event.type}"
    end

    render json: { message: "Success" }, status: :ok
  end

  private

  def handle_payment_success(payment_intent)
    # Vérifier si c'est un OrderGroup (multi-producteurs) ou un Order simple
    metadata = payment_intent.metadata || {}
    
    if metadata[:order_group_id] || metadata["order_group_id"]
      StripeMultiTransferService.handle_payment_success(payment_intent)
    elsif metadata[:order_id] || metadata["order_id"]
      StripePaymentService.handle_payment_intent_succeeded(payment_intent)
    else
      Rails.logger.warn "Payment intent without order_id or order_group_id: #{payment_intent.id}"
    end
  end

  def handle_payment_failure(payment_intent)
    # Vérifier si c'est un OrderGroup ou un Order simple
    metadata = payment_intent.metadata || {}
    
    if metadata[:order_group_id] || metadata["order_group_id"]
      StripeMultiTransferService.handle_payment_failure(payment_intent)
    elsif metadata[:order_id] || metadata["order_id"]
      StripePaymentService.handle_payment_intent_failed(payment_intent)
    else
      Rails.logger.warn "Payment intent without order_id or order_group_id: #{payment_intent.id}"
    end
  end

  def handle_account_updated(account)
    producer = Producer.find_by(stripe_account_id: account.id)
    return unless producer

    StripeConnectService.update_account_status(producer)
    Rails.logger.info "Updated account status for producer ##{producer.id}"
  end
end
