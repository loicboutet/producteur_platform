# frozen_string_literal: true

module Mockups
  module Admin
    class ProductsController < BaseController
      def index
        @products = mock_products.map.with_index do |p, i|
          p.merge(
            producer_name: i < 3 ? "Ferme du Soleil" : "Les Jardins de Pierre",
            created_at: (30 - i * 5).days.ago
          )
        end
      end

      def show
        @product = mock_product
        @product[:producer_name] = "Ferme du Soleil"
        @recent_orders = mock_admin_orders.first(3)
      end
    end
  end
end
