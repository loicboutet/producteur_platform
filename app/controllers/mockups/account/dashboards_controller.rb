# frozen_string_literal: true

module Mockups
  module Account
    class DashboardsController < Mockups::Account::BaseController
      def show
        @user = mock_current_user
        @recent_orders = mock_orders.first(3)
        @pending_order = mock_orders.find { |o| o[:status] == "ready" }
      end
    end
  end
end
