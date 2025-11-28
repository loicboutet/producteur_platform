# frozen_string_literal: true

module Mockups
  module Account
    class OrdersController < Mockups::Account::BaseController
      def index
        @orders = mock_orders
      end

      def show
        @order = {
          id: params[:id].to_i,
          reference: "CMD-2025-0042",
          status: "ready",
          status_label: "Prêt à retirer",
          created_at: 2.days.ago,
          paid_at: 2.days.ago,
          ready_at: 1.day.ago,
          total: 34.50,
          subtotal: 34.50,
          commission: 0,
          items: [
            { id: 1, name: "Tomates Bio", quantity: 2, unit: "kg", price: 4.50, subtotal: 9.00 },
            { id: 2, name: "Courgettes", quantity: 1.5, unit: "kg", price: 3.20, subtotal: 4.80 },
            { id: 3, name: "Pommes Gala", quantity: 3, unit: "kg", price: 2.80, subtotal: 8.40 },
            { id: 4, name: "Salade", quantity: 2, unit: "pièce", price: 1.50, subtotal: 3.00 },
            { id: 5, name: "Œufs Bio", quantity: 1, unit: "douzaine", price: 4.00, subtotal: 4.00 },
            { id: 6, name: "Fromage de chèvre", quantity: 1, unit: "pièce", price: 5.30, subtotal: 5.30 }
          ],
          producer: {
            id: 1,
            name: "Marie Dupont",
            farm_name: "Ferme du Soleil",
            phone: "06 12 34 56 78",
            email: "marie@fermedusoleil.fr"
          },
          pickup_point: {
            type: "farm",
            name: "À la ferme",
            address: "123 Route de la Campagne",
            postal_code: "87000",
            city: "Limoges",
            hours: [
              { day: "Lundi - Vendredi", time: "9h00 - 18h00" },
              { day: "Samedi", time: "9h00 - 12h00" }
            ]
          },
          payment: {
            method: "Carte bancaire",
            last4: "4242",
            brand: "Visa"
          }
        }
      end
    end
  end
end
