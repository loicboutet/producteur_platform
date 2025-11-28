# frozen_string_literal: true

module Mockups
  module Admin
    class DashboardsController < BaseController
      def show
        @stats = mock_admin_stats
        @pending_producers = mock_admin_producers.select { |p| p[:status] == "pending" }
        @recent_orders = mock_admin_orders.first(5)
        @recent_transactions = mock_admin_transactions.first(5)
      end
    end
  end
end
