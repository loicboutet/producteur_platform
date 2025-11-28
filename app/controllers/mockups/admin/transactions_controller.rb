# frozen_string_literal: true

module Mockups
  module Admin
    class TransactionsController < BaseController
      def index
        @transactions = mock_admin_transactions
      end

      def show
        @transaction = mock_admin_transactions.find { |t| t[:id] == params[:id].to_i } || mock_admin_transactions.first
      end
    end
  end
end
