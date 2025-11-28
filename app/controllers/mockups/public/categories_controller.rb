# frozen_string_literal: true

module Mockups
  module Public
    class CategoriesController < Mockups::Public::BaseController
      def index
        @categories = mock_categories
      end

      def show
        @category = {
          id: 1,
          name: "Fruits & Légumes",
          slug: params[:slug],
          description: "Fruits et légumes frais, de saison, cultivés par nos producteurs locaux.",
          products_count: 45,
          icon: "🥬"
        }
        @products = mock_products.select { |p| [ "Légumes", "Fruits" ].include?(p[:category]) }
      end
    end
  end
end
