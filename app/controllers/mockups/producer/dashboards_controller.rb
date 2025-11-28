# frozen_string_literal: true

module Mockups
  module Producer
    class DashboardsController < BaseController
      def show
        @producer = mock_current_producer
        @recent_orders = mock_producer_orders.first(5)
        @stats = mock_stats
        @low_stock_products = mock_producer_products.select { |p| p[:stock] <= 10 }
      end
    end
  end
end
