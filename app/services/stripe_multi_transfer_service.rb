class StripeMultiTransferService
  # Crée un paiement avec plusieurs transfers (un par producteur)
  # Utilise le pattern "Separate Charges and Transfers"
  def self.create_payment_intent(order_group)
    raise ArgumentError, "OrderGroup must have orders" if order_group.orders.empty?

    # Vérifier que tous les producteurs peuvent recevoir des paiements
    order_group.producers.each do |producer|
      unless producer.can_receive_payments?
        raise ArgumentError, "Producer #{producer.name} cannot receive payments yet"
      end
    end

    # Calculer le total en centimes
    total_cents = (order_group.total_amount * 100).to_i

    # Créer le payment intent
    payment_intent = Stripe::PaymentIntent.create({
      amount: total_cents,
      currency: "eur",
      metadata: {
        order_group_id: order_group.id.to_s,
        user_id: order_group.user_id.to_s,
        producers_count: order_group.producers_count.to_s,
        total_platform_fee: order_group.platform_fee.to_s
      },
      description: "Order Group ##{order_group.id} - #{order_group.producers_count} producers"
    })

    order_group.update!(stripe_payment_intent_id: payment_intent.id)
    payment_intent
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to create multi-transfer payment intent: #{e.message}"
    raise
  end

  # Après confirmation du paiement, créer les transfers vers chaque producteur
  def self.create_transfers(order_group)
    raise ArgumentError, "OrderGroup must be paid" unless order_group.paid?
    raise ArgumentError, "OrderGroup must have payment intent" unless order_group.stripe_payment_intent_id

    # Récupérer le charge_id du payment intent
    payment_intent = Stripe::PaymentIntent.retrieve(order_group.stripe_payment_intent_id)
    charge_id = payment_intent.latest_charge

    raise ArgumentError, "No charge found for this payment intent" unless charge_id

    transfers = []

    # Grouper les orders par producteur et créer un transfer par producteur
    orders_by_producer = order_group.orders.group_by(&:producer)

    orders_by_producer.each do |producer, orders|
      # Calculer le montant total pour ce producteur (sur un array)
      producer_total = orders.sum(&:producer_amount)
      producer_total_cents = (producer_total * 100).to_i

      # Créer le transfer vers ce producteur
      transfer = Stripe::Transfer.create({
        amount: producer_total_cents,
        currency: "eur",
        destination: producer.stripe_account_id,
        source_transaction: charge_id,
        metadata: {
          order_group_id: order_group.id.to_s,
          producer_id: producer.id.to_s,
          producer_name: producer.name,
          orders_count: orders.count.to_s
        },
        description: "Payment for #{orders.count} orders - Order Group ##{order_group.id}"
      })

      transfers << transfer

      Rails.logger.info "✅ Transfer created: #{transfer.id} - #{producer_total_cents} cents to #{producer.name}"
    end

    transfers
  rescue Stripe::StripeError => e
    Rails.logger.error "❌ Failed to create transfers: #{e.message}"
    raise
  end

  # Gérer le succès du paiement
  def self.handle_payment_success(payment_intent)
    metadata = payment_intent.metadata
    order_group_id = metadata[:order_group_id] || metadata["order_group_id"]
    
    unless order_group_id
      Rails.logger.warn "Payment intent without order_group_id: #{payment_intent.id}"
      return
    end

    order_group = OrderGroup.find_by(id: order_group_id)
    unless order_group
      Rails.logger.warn "OrderGroup not found: #{order_group_id}"
      return
    end

    ActiveRecord::Base.transaction do
      # Mettre à jour le statut du groupe
      order_group.update!(status: "paid")

      # Mettre à jour toutes les commandes et réduire le stock
      order_group.orders.each do |order|
        order.update!(status: "paid")
        order.product.reduce_stock!(order.quantity)
      end

      # Créer les transfers vers les producteurs
      create_transfers(order_group)
    end

    Rails.logger.info "🎉 Payment succeeded and transfers created for order group ##{order_group.id}"
  rescue => e
    Rails.logger.error "❌ Error handling payment success: #{e.message}"
    Rails.logger.error e.backtrace.first(5).join("\n")
    # Ne pas lever d'exception pour éviter que Stripe réessaie le webhook
  end

  # Gérer l'échec du paiement
  def self.handle_payment_failure(payment_intent)
    metadata = payment_intent.metadata
    order_group_id = metadata[:order_group_id] || metadata["order_group_id"]
    
    unless order_group_id
      Rails.logger.warn "Payment intent failed without order_group_id: #{payment_intent.id}"
      return
    end

    order_group = OrderGroup.find_by(id: order_group_id)
    unless order_group
      Rails.logger.warn "OrderGroup not found: #{order_group_id}"
      return
    end

    order_group.update!(status: "cancelled")
    order_group.orders.update_all(status: "cancelled")

    Rails.logger.info "❌ Payment failed for order group ##{order_group.id}"
  rescue => e
    Rails.logger.error "Error handling payment failure: #{e.message}"
  end

  # Récupérer un payment intent
  def self.retrieve_payment_intent(payment_intent_id)
    Stripe::PaymentIntent.retrieve(payment_intent_id)
  rescue Stripe::StripeError => e
    Rails.logger.error "Failed to retrieve payment intent: #{e.message}"
    raise
  end
end
