# frozen_string_literal: true

module Mockups
  module Producer
    class OrdersController < BaseController
      def index
        @orders = mock_producer_orders
        @status_filter = params[:status]
      end

      def show
        @order = mock_producer_orders.find { |o| o[:id] == params[:id].to_i } || mock_producer_orders.first
      end
    end
  end
end
