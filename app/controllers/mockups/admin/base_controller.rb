# frozen_string_literal: true

module Mockups
  module Admin
    class BaseController < Mockups::BaseController
      layout "mockups/admin"

      # Make mock data available in views
      helper_method :mock_admin_producers, :mock_admin_stats, :mock_admin_users,
                    :mock_admin_orders, :mock_admin_transactions, :mock_admin_categories,
                    :mock_admin_markets, :mock_settings

      private

      def mock_admin_stats
        {
          total_revenue: 125_450.00,
          monthly_revenue: 18_320.50,
          total_orders: 1_234,
          pending_orders: 45,
          total_users: 856,
          total_producers: 42,
          pending_producers: 3,
          total_products: 567,
          commission_rate: 8.0,
          commission_earned: 10_036.00
        }
      end

      def mock_admin_producers
        [
          { 
            id: 1, 
            name: "Marie Dupont", 
            farm_name: "Ferme du Soleil", 
            email: "marie@fermedusoleil.fr",
            city: "Limoges",
            status: "active",
            stripe_connected: true,
            products_count: 12,
            orders_count: 156,
            total_sales: 4_520.00,
            created_at: 6.months.ago,
            verified_at: 6.months.ago - 2.days
          },
          { 
            id: 2, 
            name: "Pierre Martin", 
            farm_name: "Les Jardins de Pierre", 
            email: "pierre@jardinsdpierre.fr",
            city: "Brive-la-Gaillarde",
            status: "active",
            stripe_connected: true,
            products_count: 8,
            orders_count: 89,
            total_sales: 2_340.00,
            created_at: 4.months.ago,
            verified_at: 4.months.ago - 1.day
          },
          { 
            id: 3, 
            name: "Sophie Bernard", 
            farm_name: "Ferme Bio du Limousin", 
            email: "sophie@fermebiolimousin.fr",
            city: "Aurillac",
            status: "pending",
            stripe_connected: false,
            products_count: 0,
            orders_count: 0,
            total_sales: 0,
            created_at: 2.days.ago,
            verified_at: nil
          },
          { 
            id: 4, 
            name: "Jean Durand", 
            farm_name: "La Ferme aux Abeilles", 
            email: "jean@fermeauxabeilles.fr",
            city: "Tulle",
            status: "pending",
            stripe_connected: false,
            products_count: 0,
            orders_count: 0,
            total_sales: 0,
            created_at: 1.day.ago,
            verified_at: nil
          },
          { 
            id: 5, 
            name: "Claire Lefèvre", 
            farm_name: "Élevage Lefèvre", 
            email: "claire@elevagelefevre.fr",
            city: "Guéret",
            status: "suspended",
            stripe_connected: true,
            products_count: 5,
            orders_count: 34,
            total_sales: 890.00,
            created_at: 8.months.ago,
            verified_at: 8.months.ago - 3.days
          }
        ]
      end

      def mock_admin_users
        [
          {
            id: 1,
            name: "Alice Moreau",
            email: "alice.moreau@email.com",
            role: "customer",
            orders_count: 12,
            total_spent: 234.50,
            created_at: 3.months.ago,
            last_sign_in: 2.days.ago
          },
          {
            id: 2,
            name: "Thomas Petit",
            email: "thomas.petit@email.com",
            role: "customer",
            orders_count: 8,
            total_spent: 156.00,
            created_at: 5.months.ago,
            last_sign_in: 1.week.ago
          },
          {
            id: 3,
            name: "Julie Richard",
            email: "julie.richard@email.com",
            role: "customer",
            orders_count: 25,
            total_spent: 567.80,
            created_at: 8.months.ago,
            last_sign_in: 1.day.ago
          },
          {
            id: 4,
            name: "Admin Silloun",
            email: "admin@silloun.fr",
            role: "admin",
            orders_count: 0,
            total_spent: 0,
            created_at: 1.year.ago,
            last_sign_in: Time.current
          }
        ]
      end

      def mock_admin_orders
        [
          {
            id: 1,
            reference: "CMD-2025-0156",
            customer_name: "Alice Moreau",
            customer_email: "alice.moreau@email.com",
            producer_name: "Ferme du Soleil",
            status: "new",
            total: 45.80,
            commission: 3.66,
            created_at: 1.hour.ago,
            pickup_type: "farm"
          },
          {
            id: 2,
            reference: "CMD-2025-0155",
            customer_name: "Thomas Petit",
            customer_email: "thomas.petit@email.com",
            producer_name: "Les Jardins de Pierre",
            status: "paid",
            total: 32.50,
            commission: 2.60,
            created_at: 3.hours.ago,
            pickup_type: "market"
          },
          {
            id: 3,
            reference: "CMD-2025-0154",
            customer_name: "Julie Richard",
            customer_email: "julie.richard@email.com",
            producer_name: "Ferme du Soleil",
            status: "ready",
            total: 78.20,
            commission: 6.26,
            created_at: 1.day.ago,
            pickup_type: "farm"
          },
          {
            id: 4,
            reference: "CMD-2025-0153",
            customer_name: "Marc Dubois",
            customer_email: "marc.dubois@email.com",
            producer_name: "Les Jardins de Pierre",
            status: "picked_up",
            total: 25.00,
            commission: 2.00,
            created_at: 2.days.ago,
            pickup_type: "market"
          }
        ]
      end

      def mock_admin_transactions
        [
          {
            id: 1,
            reference: "TRX-2025-0089",
            order_reference: "CMD-2025-0153",
            type: "payment",
            amount: 25.00,
            commission: 2.00,
            producer_amount: 23.00,
            producer_name: "Les Jardins de Pierre",
            status: "completed",
            stripe_id: "pi_3NxYZ...",
            created_at: 2.days.ago
          },
          {
            id: 2,
            reference: "TRX-2025-0088",
            order_reference: "CMD-2025-0154",
            type: "payment",
            amount: 78.20,
            commission: 6.26,
            producer_amount: 71.94,
            producer_name: "Ferme du Soleil",
            status: "completed",
            stripe_id: "pi_3NxYY...",
            created_at: 1.day.ago
          },
          {
            id: 3,
            reference: "TRX-2025-0087",
            order_reference: "CMD-2025-0155",
            type: "payment",
            amount: 32.50,
            commission: 2.60,
            producer_amount: 29.90,
            producer_name: "Les Jardins de Pierre",
            status: "pending",
            stripe_id: "pi_3NxYX...",
            created_at: 3.hours.ago
          },
          {
            id: 4,
            reference: "TRX-2025-0086",
            order_reference: "CMD-2025-0150",
            type: "refund",
            amount: -15.00,
            commission: -1.20,
            producer_amount: -13.80,
            producer_name: "Ferme du Soleil",
            status: "completed",
            stripe_id: "re_3NxYW...",
            created_at: 3.days.ago
          }
        ]
      end

      def mock_admin_categories
        [
          { id: 1, name: "Fruits & Légumes", slug: "fruits-legumes", products_count: 145, icon: "🥬", position: 1, active: true },
          { id: 2, name: "Produits laitiers", slug: "produits-laitiers", products_count: 67, icon: "🧀", position: 2, active: true },
          { id: 3, name: "Viandes & Volailles", slug: "viandes-volailles", products_count: 52, icon: "🥩", position: 3, active: true },
          { id: 4, name: "Boulangerie", slug: "boulangerie", products_count: 34, icon: "🥖", position: 4, active: true },
          { id: 5, name: "Miel & Confitures", slug: "miel-confitures", products_count: 28, icon: "🍯", position: 5, active: true },
          { id: 6, name: "Boissons", slug: "boissons", products_count: 41, icon: "🍷", position: 6, active: true },
          { id: 7, name: "Épicerie", slug: "epicerie", products_count: 89, icon: "🫒", position: 7, active: true },
          { id: 8, name: "Produits de la mer", slug: "produits-mer", products_count: 12, icon: "🐟", position: 8, active: false }
        ]
      end

      def mock_admin_markets
        [
          {
            id: 1,
            name: "Marché de Limoges",
            address: "Place de la Motte",
            city: "Limoges",
            postal_code: "87000",
            days: ["Samedi"],
            hours: "8h00 - 13h00",
            producers_count: 8,
            active: true,
            latitude: 45.8336,
            longitude: 1.2611
          },
          {
            id: 2,
            name: "Marché de Brive",
            address: "Place du 14 Juillet",
            city: "Brive-la-Gaillarde",
            postal_code: "19100",
            days: ["Mardi", "Samedi"],
            hours: "7h00 - 13h00",
            producers_count: 12,
            active: true,
            latitude: 45.1588,
            longitude: 1.5333
          },
          {
            id: 3,
            name: "Marché Bio d'Aurillac",
            address: "Place du Square",
            city: "Aurillac",
            postal_code: "15000",
            days: ["Mercredi"],
            hours: "8h00 - 12h30",
            producers_count: 6,
            active: true,
            latitude: 44.9306,
            longitude: 2.4397
          },
          {
            id: 4,
            name: "Marché de Tulle",
            address: "Quai de Rigny",
            city: "Tulle",
            postal_code: "19000",
            days: ["Mercredi", "Samedi"],
            hours: "7h30 - 12h30",
            producers_count: 4,
            active: false,
            latitude: 45.2667,
            longitude: 1.7667
          }
        ]
      end

      def mock_settings
        {
          commission_rate: 8.0,
          min_order_amount: 10.00,
          max_pickup_radius: 50,
          contact_email: "contact@silloun.fr",
          support_phone: "05 55 00 00 00",
          stripe_mode: "test",
          email_notifications: true
          
        }
      end
    end
  end
end
