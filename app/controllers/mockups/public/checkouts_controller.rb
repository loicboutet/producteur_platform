# frozen_string_literal: true

module Mockups
  module Public
    class CheckoutsController < Mockups::Public::BaseController
      def show
        @cart_items = mock_cart_items
        @cart_total = @cart_items.sum { |item| item[:subtotal] }

        @pickup_options = {
          1 => [
            { id: 1, type: "farm", name: "Ferme du Soleil", address: "123 Route de la Campagne, 87000 Limoges", next_slot: "Samedi 14h-18h" },
            { id: 2, type: "market", name: "Marché de Limoges", address: "Place de la Motte, 87000 Limoges", next_slot: "Samedi 8h-13h" }
          ],
          2 => [
            { id: 3, type: "farm", name: "Chèvrerie des Collines", address: "45 Chemin des Chèvres, 15000 Aurillac", next_slot: "Vendredi 10h-17h" }
          ]
        }
      end

      def payment
        @order_total = 34.40
        @stripe_public_key = "pk_test_xxx"
      end

      def success
        @order = mock_order
      end
    end
  end
end
