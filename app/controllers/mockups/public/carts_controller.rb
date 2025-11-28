# frozen_string_literal: true

module Mockups
  module Public
    class CartsController < Mockups::Public::BaseController
      def show
        @cart_items = [
          {
            id: 1,
            product: { id: 1, name: "Tomates Bio", price: 4.50, unit: "kg", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
            quantity: 2,
            subtotal: 9.00,
            producer: { id: 1, name: "Ferme du Soleil" }
          },
          {
            id: 2,
            product: { id: 3, name: "Pommes Gala", price: 2.80, unit: "kg", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
            quantity: 3,
            subtotal: 8.40,
            producer: { id: 1, name: "Ferme du Soleil" }
          },
          {
            id: 3,
            product: { id: 6, name: "Fromage de chèvre", price: 8.50, unit: "pièce", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
            quantity: 2,
            subtotal: 17.00,
            producer: { id: 3, name: "Chèvrerie des Collines" }
          }
        ]

        @cart_total = @cart_items.sum { |item| item[:subtotal] }

        # Group by producer
        @cart_by_producer = @cart_items.group_by { |item| item[:producer][:id] }
      end
    end
  end
end
