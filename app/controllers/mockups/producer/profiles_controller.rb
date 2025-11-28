# frozen_string_literal: true

module Mockups
  module Producer
    class ProfilesController < BaseController
      def show
        @producer = mock_current_producer
        @pickup_points = mock_pickup_points
        @market_presences = mock_market_presences
      end

      def edit
        @producer = mock_current_producer
      end

      def update
        redirect_to mockups_producer_profile_path, notice: "Profil mis à jour avec succès"
      end
    end
  end
end
