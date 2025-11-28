# frozen_string_literal: true

module Mockups
  class BaseController < ApplicationController
    layout "mockups/application"

    # Skip authentication for all mockup pages
    skip_before_action :authenticate_user!, raise: false

    private

    # Helper to provide mock data consistently
    def mock_producer
      {
        id: 1,
        name: "Marie Dupont",
        farm_name: "Ferme du Soleil",
        description: "Maraîchère passionnée depuis 15 ans, je cultive des légumes bio dans le respect de la terre.",
        address: "123 Route de la Campagne",
        city: "Limoges",
        postal_code: "87000",
        phone: "06 12 34 56 78",
        email: "marie@fermedusoleil.fr",
        siret: "123 456 789 00012",
        distance: 2.3,
        products_count: 12,
        verified: true,
        stripe_connected: true
      }
    end

    def mock_product
      {
        id: 1,
        name: "Tomates Bio",
        description: "Tomates cultivées sans pesticides, récoltées à maturité pour un goût incomparable.",
        price: 4.50,
        unit: "kg",
        stock: 25,
        available: true,
        category: "Légumes",
        producer: mock_producer,
        images: [
          "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png"
        ]
      }
    end

    def mock_products
      [
        { id: 1, name: "Tomates Bio", price: 4.50, unit: "kg", stock: 25, available: true, category: "Légumes" },
        { id: 2, name: "Courgettes", price: 3.20, unit: "kg", stock: 0, available: false, category: "Légumes" },
        { id: 3, name: "Pommes Gala", price: 2.80, unit: "kg", stock: 50, available: true, category: "Fruits" },
        { id: 4, name: "Fraises", price: 6.50, unit: "barquette", stock: 15, available: true, category: "Fruits" },
        { id: 5, name: "Œufs Bio", price: 4.00, unit: "douzaine", stock: 30, available: true, category: "Produits laitiers" },
        { id: 6, name: "Fromage de chèvre", price: 8.50, unit: "pièce", stock: 10, available: true, category: "Produits laitiers" }
      ]
    end

    def mock_categories
      [
        { id: 1, name: "Fruits & Légumes", slug: "fruits-legumes", products_count: 45, icon: "🥬" },
        { id: 2, name: "Produits laitiers", slug: "produits-laitiers", products_count: 23, icon: "🧀" },
        { id: 3, name: "Viandes & Volailles", slug: "viandes-volailles", products_count: 18, icon: "🥩" },
        { id: 4, name: "Boulangerie", slug: "boulangerie", products_count: 12, icon: "🥖" },
        { id: 5, name: "Miel & Confitures", slug: "miel-confitures", products_count: 8, icon: "🍯" },
        { id: 6, name: "Boissons", slug: "boissons", products_count: 15, icon: "🍷" }
      ]
    end

    def mock_market
      {
        id: 1,
        name: "Marché de Limoges",
        address: "Place de la Motte",
        city: "Limoges",
        postal_code: "87000",
        days: [ "Samedi" ],
        hours: "8h00 - 13h00",
        producers_count: 8,
        distance: 1.5
      }
    end

    def mock_markets
      [
        { id: 1, name: "Marché de Limoges", city: "Limoges", days: [ "Samedi" ], hours: "8h-13h", producers_count: 8, distance: 1.5 },
        { id: 2, name: "Marché de Brive", city: "Brive-la-Gaillarde", days: [ "Mardi", "Samedi" ], hours: "7h-13h", producers_count: 12, distance: 5.2 },
        { id: 3, name: "Marché Bio d'Aurillac", city: "Aurillac", days: [ "Mercredi" ], hours: "8h-12h30", producers_count: 6, distance: 8.7 }
      ]
    end

    def mock_order
      {
        id: 1,
        reference: "CMD-2025-0001",
        status: "ready",
        created_at: 2.days.ago,
        total: 45.80,
        items: [
          { name: "Tomates Bio", quantity: 2, unit: "kg", price: 4.50, subtotal: 9.00 },
          { name: "Pommes Gala", quantity: 3, unit: "kg", price: 2.80, subtotal: 8.40 },
          { name: "Fromage de chèvre", quantity: 2, unit: "pièce", price: 8.50, subtotal: 17.00 }
        ],
        pickup_point: {
          type: "farm",
          name: "Ferme du Soleil",
          address: "123 Route de la Campagne, 87000 Limoges",
          hours: "Lun-Ven 9h-18h, Sam 9h-12h"
        },
        producer: mock_producer
      }
    end

    def mock_cart_items
      [
        { id: 1, product: mock_products[0], quantity: 2, subtotal: 9.00, producer_id: 1 },
        { id: 2, product: mock_products[2], quantity: 3, subtotal: 8.40, producer_id: 1 },
        { id: 3, product: mock_products[5], quantity: 2, subtotal: 17.00, producer_id: 2 }
      ]
    end
  end
end
