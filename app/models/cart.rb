class Cart < ApplicationRecord
  belongs_to :user, optional: true # Peut être nil pour les invités
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :session_id, presence: true, uniqueness: true

  # Récupérer ou créer un panier pour une session
  def self.for_session(session_id, user = nil)
    cart = find_or_create_by(session_id: session_id)
    cart.update(user: user) if user && !cart.user
    cart
  end

  # Ajouter un produit au panier
  def add_product(product, quantity = 1)
    cart_item = cart_items.find_by(product: product)

    if cart_item
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  # Mettre à jour la quantité d'un produit
  def update_quantity(product, quantity)
    cart_item = cart_items.find_by(product: product)
    return unless cart_item

    if quantity <= 0
      cart_item.destroy
    else
      cart_item.update(quantity: quantity)
    end
  end

  # Supprimer un produit du panier
  def remove_product(product)
    cart_items.find_by(product: product)&.destroy
  end

  # Vider le panier
  def clear
    cart_items.destroy_all
  end

  # Total du panier
  def total
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # Nombre total d'articles
  def total_items
    cart_items.sum(:quantity)
  end

  # Grouper les articles par producteur
  def items_by_producer
    cart_items.includes(product: :producer).group_by { |item| item.product.producer }
  end

  # Liste des producteurs dans le panier
  def producers
    Producer.joins(products: :cart_items).where(cart_items: { cart_id: id }).distinct
  end

  # Vérifier si le panier est vide
  def empty?
    cart_items.count.zero?
  end

  # Calculer les montants pour chaque producteur
  def producer_amounts
    items_by_producer.map do |producer, items|
      subtotal = items.sum { |item| item.product.price * item.quantity }
      platform_fee = (subtotal * 0.10).round(2)
      producer_amount = (subtotal - platform_fee).round(2)

      {
        producer: producer,
        items: items,
        subtotal: subtotal,
        platform_fee: platform_fee,
        producer_amount: producer_amount
      }
    end
  end

  # Commission totale de la plateforme
  def total_platform_fee
    (total * 0.10).round(2)
  end
end
