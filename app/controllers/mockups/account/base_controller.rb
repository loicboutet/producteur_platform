# frozen_string_literal: true

module Mockups
  module Account
    class BaseController < Mockups::BaseController
      layout "mockups/account"

      private

      def mock_current_user
        {
          id: 1,
          email: "jean.martin@email.com",
          first_name: "Jean",
          last_name: "Martin",
          phone: "06 12 34 56 78",
          address: "45 rue des Lilas",
          postal_code: "87000",
          city: "Limoges",
          created_at: 6.months.ago,
          orders_count: 12,
          total_spent: 345.80
        }
      end

      def mock_orders
        [
          {
            id: 1,
            reference: "CMD-2025-0042",
            status: "ready",
            status_label: "Prêt à retirer",
            created_at: 2.days.ago,
            total: 34.50,
            items_count: 4,
            producer: { name: "Ferme du Soleil", farm_name: "Ferme du Soleil" },
            pickup_point: { name: "À la ferme", type: "farm" }
          },
          {
            id: 2,
            reference: "CMD-2025-0038",
            status: "picked_up",
            status_label: "Retiré",
            created_at: 1.week.ago,
            total: 52.80,
            items_count: 6,
            producer: { name: "Les Vergers du Limousin", farm_name: "Les Vergers du Limousin" },
            pickup_point: { name: "Marché de Limoges", type: "market" }
          },
          {
            id: 3,
            reference: "CMD-2025-0031",
            status: "picked_up",
            status_label: "Retiré",
            created_at: 2.weeks.ago,
            total: 28.00,
            items_count: 3,
            producer: { name: "Chèvrerie des Collines", farm_name: "Chèvrerie des Collines" },
            pickup_point: { name: "À la ferme", type: "farm" }
          },
          {
            id: 4,
            reference: "CMD-2025-0025",
            status: "picked_up",
            status_label: "Retiré",
            created_at: 3.weeks.ago,
            total: 45.20,
            items_count: 5,
            producer: { name: "Ferme du Soleil", farm_name: "Ferme du Soleil" },
            pickup_point: { name: "Marché de Brive", type: "market" }
          }
        ]
      end
    end
  end
end
