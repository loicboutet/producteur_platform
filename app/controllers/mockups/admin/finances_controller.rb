# frozen_string_literal: true

module Mockups
  module Admin
    class FinancesController < BaseController
      def show
        @stats = mock_admin_stats
        @recent_transactions = mock_admin_transactions
      end
    end
  end
end
