# frozen_string_literal: true

module Mockups
  module Producer
    class BaseController < Mockups::BaseController
      layout "mockups/producer"

      private

      def mock_current_producer
        {
          id: 1,
          email: "marie@fermedusoleil.fr",
          first_name: "Marie",
          last_name: "Dupont",
          farm_name: "Ferme du Soleil",
          description: "Maraîchère passionnée depuis 15 ans, je cultive des légumes bio dans le respect de la terre et des saisons. Ma ferme est certifiée Agriculture Biologique depuis 2010.",
          short_description: "Légumes bio de saison, cultivés avec passion",
          phone: "06 12 34 56 78",
          address: "123 Route de la Campagne",
          postal_code: "87000",
          city: "Limoges",
          siret: "123 456 789 00012",
          created_at: 2.years.ago,
          verified: true,
          stripe_connected: true,
          stripe_account_id: "acct_1234567890",
          products_count: 12,
          orders_count: 156,
          total_revenue: 8_450.80,
          this_month_revenue: 1_234.50,
          photo: "pictures/vobs.studio_Portrait_dune_agricultrice._Elle_porte_une_salopett_33ef692c-abe1-483a-89e1-28b000f76624.png"
        }
      end

      def mock_producer_products
        [
          {
            id: 1,
            name: "Tomates Bio",
            description: "Tomates cultivées sans pesticides, récoltées à maturité",
            price: 4.50,
            unit: "kg",
            stock: 25,
            available: true,
            category: "Légumes",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 45,
            created_at: 6.months.ago
          },
          {
            id: 2,
            name: "Courgettes",
            description: "Courgettes fraîches du jardin",
            price: 3.20,
            unit: "kg",
            stock: 0,
            available: false,
            category: "Légumes",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 32,
            created_at: 6.months.ago
          },
          {
            id: 3,
            name: "Pommes Gala",
            description: "Pommes croquantes et sucrées",
            price: 2.80,
            unit: "kg",
            stock: 50,
            available: true,
            category: "Fruits",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 78,
            created_at: 4.months.ago
          },
          {
            id: 4,
            name: "Fraises",
            description: "Fraises de plein champ, parfumées",
            price: 6.50,
            unit: "barquette 500g",
            stock: 15,
            available: true,
            category: "Fruits",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 23,
            created_at: 2.months.ago
          },
          {
            id: 5,
            name: "Œufs Bio",
            description: "Œufs de poules élevées en plein air",
            price: 4.00,
            unit: "douzaine",
            stock: 30,
            available: true,
            category: "Produits laitiers",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 89,
            created_at: 8.months.ago
          },
          {
            id: 6,
            name: "Miel de Fleurs",
            description: "Miel toutes fleurs de nos ruches",
            price: 12.00,
            unit: "pot 500g",
            stock: 8,
            available: true,
            category: "Miel & Confitures",
            image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png",
            sales_count: 15,
            created_at: 1.month.ago
          }
        ]
      end

      def mock_producer_orders
        [
          {
            id: 1,
            reference: "CMD-2025-0089",
            status: "new",
            status_label: "Nouvelle",
            status_color: "blue",
            created_at: 30.minutes.ago,
            total: 34.50,
            items_count: 4,
            customer: { name: "Jean Martin", email: "jean.martin@email.com", phone: "06 98 76 54 32" },
            pickup_point: { name: "À la ferme", type: "farm", date: Date.tomorrow, time: "10h00 - 12h00" },
            items: [
              { name: "Tomates Bio", quantity: 2, unit: "kg", price: 4.50, subtotal: 9.00 },
              { name: "Pommes Gala", quantity: 3, unit: "kg", price: 2.80, subtotal: 8.40 },
              { name: "Œufs Bio", quantity: 1, unit: "douzaine", price: 4.00, subtotal: 4.00 },
              { name: "Miel de Fleurs", quantity: 1, unit: "pot 500g", price: 12.00, subtotal: 12.00 }
            ]
          },
          {
            id: 2,
            reference: "CMD-2025-0088",
            status: "new",
            status_label: "Nouvelle",
            status_color: "blue",
            created_at: 2.hours.ago,
            total: 28.00,
            items_count: 3,
            customer: { name: "Sophie Durand", email: "sophie.durand@email.com", phone: "06 11 22 33 44" },
            pickup_point: { name: "Marché de Limoges", type: "market", date: Date.parse("Saturday"), time: "8h00 - 13h00" },
            items: [
              { name: "Fraises", quantity: 2, unit: "barquette 500g", price: 6.50, subtotal: 13.00 },
              { name: "Pommes Gala", quantity: 2, unit: "kg", price: 2.80, subtotal: 5.60 },
              { name: "Œufs Bio", quantity: 2, unit: "douzaine", price: 4.00, subtotal: 8.00 }
            ]
          },
          {
            id: 3,
            reference: "CMD-2025-0087",
            status: "new",
            status_label: "Nouvelle",
            status_color: "blue",
            created_at: 5.hours.ago,
            total: 18.50,
            items_count: 2,
            customer: { name: "Pierre Moreau", email: "pierre.moreau@email.com", phone: "06 55 66 77 88" },
            pickup_point: { name: "À la ferme", type: "farm", date: Date.tomorrow, time: "14h00 - 18h00" },
            items: [
              { name: "Tomates Bio", quantity: 3, unit: "kg", price: 4.50, subtotal: 13.50 },
              { name: "Œufs Bio", quantity: 1, unit: "douzaine", price: 4.00, subtotal: 4.00 }
            ]
          },
          {
            id: 4,
            reference: "CMD-2025-0085",
            status: "preparing",
            status_label: "En préparation",
            status_color: "yellow",
            created_at: 1.day.ago,
            total: 45.80,
            items_count: 5,
            customer: { name: "Marie Lambert", email: "marie.lambert@email.com", phone: "06 22 33 44 55" },
            pickup_point: { name: "À la ferme", type: "farm", date: Date.today, time: "10h00 - 12h00" },
            items: [
              { name: "Tomates Bio", quantity: 2, unit: "kg", price: 4.50, subtotal: 9.00 },
              { name: "Courgettes", quantity: 2, unit: "kg", price: 3.20, subtotal: 6.40 },
              { name: "Pommes Gala", quantity: 3, unit: "kg", price: 2.80, subtotal: 8.40 },
              { name: "Œufs Bio", quantity: 2, unit: "douzaine", price: 4.00, subtotal: 8.00 },
              { name: "Miel de Fleurs", quantity: 1, unit: "pot 500g", price: 12.00, subtotal: 12.00 }
            ]
          },
          {
            id: 5,
            reference: "CMD-2025-0082",
            status: "ready",
            status_label: "Prêt à retirer",
            status_color: "green",
            created_at: 2.days.ago,
            total: 22.30,
            items_count: 3,
            customer: { name: "Thomas Bernard", email: "thomas.bernard@email.com", phone: "06 66 77 88 99" },
            pickup_point: { name: "Marché de Brive", type: "market", date: Date.today, time: "7h00 - 13h00" },
            items: [
              { name: "Pommes Gala", quantity: 4, unit: "kg", price: 2.80, subtotal: 11.20 },
              { name: "Fraises", quantity: 1, unit: "barquette 500g", price: 6.50, subtotal: 6.50 },
              { name: "Œufs Bio", quantity: 1, unit: "douzaine", price: 4.00, subtotal: 4.00 }
            ]
          },
          {
            id: 6,
            reference: "CMD-2025-0078",
            status: "picked_up",
            status_label: "Retiré",
            status_color: "gray",
            created_at: 5.days.ago,
            total: 38.70,
            items_count: 4,
            customer: { name: "Claire Petit", email: "claire.petit@email.com", phone: "06 33 44 55 66" },
            pickup_point: { name: "À la ferme", type: "farm", date: 5.days.ago.to_date, time: "10h00 - 12h00" },
            items: [
              { name: "Tomates Bio", quantity: 3, unit: "kg", price: 4.50, subtotal: 13.50 },
              { name: "Courgettes", quantity: 2, unit: "kg", price: 3.20, subtotal: 6.40 },
              { name: "Pommes Gala", quantity: 2, unit: "kg", price: 2.80, subtotal: 5.60 },
              { name: "Miel de Fleurs", quantity: 1, unit: "pot 500g", price: 12.00, subtotal: 12.00 }
            ]
          }
        ]
      end

      def mock_pickup_points
        [
          {
            id: 1,
            type: "farm",
            name: "À la ferme",
            address: "123 Route de la Campagne",
            postal_code: "87000",
            city: "Limoges",
            description: "Retrait directement à la ferme. Parking disponible.",
            active: true,
            schedules: [
              { day: "Lundi", open: "09:00", close: "12:00", active: true },
              { day: "Mardi", open: "09:00", close: "12:00", active: true },
              { day: "Mercredi", open: "09:00", close: "12:00", active: true },
              { day: "Mercredi", open: "14:00", close: "18:00", active: true },
              { day: "Jeudi", open: "09:00", close: "12:00", active: true },
              { day: "Vendredi", open: "09:00", close: "12:00", active: true },
              { day: "Vendredi", open: "14:00", close: "18:00", active: true },
              { day: "Samedi", open: "09:00", close: "12:00", active: true }
            ]
          }
        ]
      end

      def mock_market_presences
        [
          {
            id: 1,
            market: {
              id: 1,
              name: "Marché de Limoges",
              address: "Place de la Motte",
              city: "Limoges"
            },
            day: "Samedi",
            start_time: "08:00",
            end_time: "13:00",
            active: true,
            stand_number: "A12"
          },
          {
            id: 2,
            market: {
              id: 2,
              name: "Marché de Brive",
              address: "Place de la Guierle",
              city: "Brive-la-Gaillarde"
            },
            day: "Mardi",
            start_time: "07:00",
            end_time: "13:00",
            active: true,
            stand_number: "B8"
          }
        ]
      end

      def mock_stats
        {
          total_revenue: 8_450.80,
          this_month_revenue: 1_234.50,
          last_month_revenue: 1_089.20,
          revenue_growth: 13.3,
          total_orders: 156,
          this_month_orders: 23,
          last_month_orders: 19,
          orders_growth: 21.1,
          average_order: 53.65,
          total_customers: 89,
          returning_customers: 34,
          returning_rate: 38.2,
          top_products: [
            { name: "Œufs Bio", sales: 89, revenue: 356.00 },
            { name: "Pommes Gala", sales: 78, revenue: 218.40 },
            { name: "Tomates Bio", sales: 45, revenue: 202.50 },
            { name: "Courgettes", sales: 32, revenue: 102.40 },
            { name: "Fraises", sales: 23, revenue: 149.50 }
          ],
          monthly_revenue: [
            { month: "Jan", revenue: 890.50 },
            { month: "Fév", revenue: 756.20 },
            { month: "Mar", revenue: 923.80 },
            { month: "Avr", revenue: 1_045.30 },
            { month: "Mai", revenue: 1_089.20 },
            { month: "Juin", revenue: 1_234.50 }
          ],
          pickup_distribution: [
            { type: "À la ferme", count: 98, percentage: 62.8 },
            { type: "Marché de Limoges", count: 42, percentage: 26.9 },
            { type: "Marché de Brive", count: 16, percentage: 10.3 }
          ]
        }
      end
    end
  end
end
