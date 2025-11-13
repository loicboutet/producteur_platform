class StripePaymentService
  PLATFORM_FEE_PERCENTAGE = 10 # 10% platform fee

  # Create a payment intent with split payment (Destination Charges pattern)
  def self.create_payment_intent(order)
    raise ArgumentError, "Order must have a producer with Stripe account" unless order.producer.stripe_account_id
    raise ArgumentError, "Producer account must be active" unless order.producer.can_receive_payments?

    # Calculate amounts in cents
    total_cents = (order.total_amount * 100).to_i
    platform_fee_cents = (order.platform_fee * 100).to_i

    # Create payment intent with destination charges
    # This automatically splits the payment:
    # - Producer gets the full amount minus platform fee in their Stripe account
    # - Platform keeps the application fee
    payment_intent = Stripe::PaymentIntent.create({
      amount: total_cents,
      currency: "eur",
      application_fee_amount: platform_fee_cents,
      transfer_data: {
        destination: order.producer.stripe_account_id
      },
      metadata: {
        order_id: order.id.to_s,
        producer_id: order.producer.id.to_s,
        product_id: order.product.id.to_s,
        platform_fee: order.platform_fee.to_s,
        producer_amount: order.producer_amount.to_s
      },
      description: "Order ##{order.id} - #{order.product.name} x#{order.quantity}"
    })

    order.update!(stripe_payment_intent_id: payment_intent.id)
    payment_intent
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to create payment intent: #{e.message}"
    raise
  end

  # Confirm a payment intent
  def self.confirm_payment(payment_intent_id, payment_method_id)
    Stripe::PaymentIntent.confirm(
      payment_intent_id,
      { payment_method: payment_method_id }
    )
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to confirm payment: #{e.message}"
    raise
  end

  # Get payment intent status
  def self.retrieve_payment_intent(payment_intent_id)
    Stripe::PaymentIntent.retrieve(payment_intent_id)
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to retrieve payment intent: #{e.message}"
    raise
  end

  # Handle webhook events
  def self.handle_payment_intent_succeeded(payment_intent)
    metadata = payment_intent.metadata
    order_id = metadata[:order_id] || metadata["order_id"]
    
    unless order_id
      Rails.logger.warn "Payment intent succeeded without order_id: #{payment_intent.id}"
      return
    end

    order = Order.find_by(id: order_id)
    unless order
      Rails.logger.warn "Order not found for payment intent: #{payment_intent.id}"
      return
    end

    order.update!(status: "paid")
    order.product.reduce_stock!(order.quantity)

    Rails.logger.info "✅ Payment succeeded for order ##{order.id} - Stock reduced"
  rescue => e
    Rails.logger.error "Error handling payment success: #{e.message}"
  end

  def self.handle_payment_intent_failed(payment_intent)
    metadata = payment_intent.metadata
    order_id = metadata[:order_id] || metadata["order_id"]
    
    unless order_id
      Rails.logger.warn "Payment intent failed without order_id: #{payment_intent.id}"
      return
    end

    order = Order.find_by(id: order_id)
    unless order
      Rails.logger.warn "Order not found for payment intent: #{payment_intent.id}"
      return
    end

    order.update!(status: "cancelled")

    Rails.logger.info "❌ Payment failed for order ##{order.id}"
  rescue => e
    Rails.logger.error "Error handling payment failure: #{e.message}"
  end

  # Calculate platform fee and producer amount
  def self.calculate_split(total_amount, fee_percentage = PLATFORM_FEE_PERCENTAGE)
    platform_fee = (total_amount * fee_percentage / 100.0).round(2)
    producer_amount = (total_amount - platform_fee).round(2)

    {
      total_amount: total_amount,
      platform_fee: platform_fee,
      producer_amount: producer_amount
    }
  end
end
