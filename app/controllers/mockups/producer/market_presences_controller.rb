# frozen_string_literal: true

module Mockups
  module Producer
    class MarketPresencesController < BaseController
      def index
        @market_presences = mock_market_presences
        @available_markets = mock_markets
      end

      def new
        @market_presence = {}
        @available_markets = mock_markets
      end

      def create
        redirect_to mockups_producer_market_presences_path, notice: "Présence sur le marché créée"
      end

      def edit
        @market_presence = mock_market_presences.find { |m| m[:id] == params[:id].to_i } || mock_market_presences.first
        @available_markets = mock_markets
      end

      def update
        redirect_to mockups_producer_market_presences_path, notice: "Présence mise à jour"
      end

      def destroy
        redirect_to mockups_producer_market_presences_path, notice: "Présence supprimée"
      end
    end
  end
end
