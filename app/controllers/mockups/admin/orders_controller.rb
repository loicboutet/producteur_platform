# frozen_string_literal: true

module Mockups
  module Admin
    class OrdersController < BaseController
      def index
        @orders = mock_admin_orders
        @status_filter = params[:status]
        
        if @status_filter.present?
          @orders = @orders.select { |o| o[:status] == @status_filter }
        end
      end

      def show
        @order = mock_admin_orders.find { |o| o[:id] == params[:id].to_i } || mock_admin_orders.first
        @order_items = [
          { name: "Tomates Bio", quantity: 2, unit: "kg", price: 4.50, subtotal: 9.00 },
          { name: "Pommes Gala", quantity: 3, unit: "kg", price: 2.80, subtotal: 8.40 },
          { name: "Fromage de chèvre", quantity: 2, unit: "pièce", price: 8.50, subtotal: 17.00 }
        ]
      end
    end
  end
end
