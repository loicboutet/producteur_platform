# frozen_string_literal: true

module Mockups
  module Producer
    class StatsController < BaseController
      def show
        @producer = mock_current_producer
        @stats = mock_stats
        @products = mock_producer_products
      end
    end
  end
end
