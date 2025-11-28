# frozen_string_literal: true

module Mockups
  module Producer
    class PickupPointsController < BaseController
      def index
        @pickup_points = mock_pickup_points
      end

      def new
        @pickup_point = {}
      end

      def create
        redirect_to mockups_producer_pickup_points_path, notice: "Point de retrait créé avec succès"
      end

      def edit
        @pickup_point = mock_pickup_points.first
      end

      def update
        redirect_to mockups_producer_pickup_points_path, notice: "Point de retrait mis à jour"
      end

      def destroy
        redirect_to mockups_producer_pickup_points_path, notice: "Point de retrait supprimé"
      end
    end
  end
end
