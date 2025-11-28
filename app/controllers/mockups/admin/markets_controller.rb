# frozen_string_literal: true

module Mockups
  module Admin
    class MarketsController < BaseController
      def index
        @markets = mock_admin_markets
      end

      def show
        @market = mock_admin_markets.find { |m| m[:id] == params[:id].to_i } || mock_admin_markets.first
        @producers = mock_admin_producers.first(4)
      end

      def new
        @market = { id: nil, name: "", address: "", city: "", postal_code: "", days: [], hours: "", active: true }
      end

      def create
        redirect_to mockups_admin_markets_path, notice: "Marché créé"
      end

      def edit
        @market = mock_admin_markets.find { |m| m[:id] == params[:id].to_i } || mock_admin_markets.first
      end

      def update
        redirect_to mockups_admin_market_path(params[:id]), notice: "Marché mis à jour"
      end

      def destroy
        redirect_to mockups_admin_markets_path, notice: "Marché supprimé"
      end
    end
  end
end
