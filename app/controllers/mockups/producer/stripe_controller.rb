# frozen_string_literal: true

module Mockups
  module Producer
    class StripeController < BaseController
      def show
        @producer = mock_current_producer
        @transactions = mock_transactions
        @pending_balance = 234.50
        @available_balance = 1_850.30
      end

      def connect
        @producer = mock_current_producer
      end

      private

      def mock_transactions
        [
          { id: 1, reference: "CMD-2025-0089", date: 1.day.ago, amount: 34.50, commission: 3.45, net: 31.05, status: "pending" },
          { id: 2, reference: "CMD-2025-0088", date: 2.days.ago, amount: 28.00, commission: 2.80, net: 25.20, status: "pending" },
          { id: 3, reference: "CMD-2025-0085", date: 3.days.ago, amount: 45.80, commission: 4.58, net: 41.22, status: "paid" },
          { id: 4, reference: "CMD-2025-0082", date: 5.days.ago, amount: 22.30, commission: 2.23, net: 20.07, status: "paid" },
          { id: 5, reference: "CMD-2025-0078", date: 1.week.ago, amount: 38.70, commission: 3.87, net: 34.83, status: "paid" }
        ]
      end
    end
  end
end
