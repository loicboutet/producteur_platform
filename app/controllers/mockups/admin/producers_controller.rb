# frozen_string_literal: true

module Mockups
  module Admin
    class ProducersController < BaseController
      def index
        @producers = mock_admin_producers
        @status_filter = params[:status]
        
        if @status_filter.present?
          @producers = @producers.select { |p| p[:status] == @status_filter }
        end
      end

      def show
        @producer = mock_admin_producers.find { |p| p[:id] == params[:id].to_i } || mock_admin_producers.first
        @recent_orders = mock_admin_orders.select { |o| o[:producer_name] == @producer[:farm_name] }
        @recent_products = mock_products.first(5)
      end

      def edit
        @producer = mock_admin_producers.find { |p| p[:id] == params[:id].to_i } || mock_admin_producers.first
      end

      def update
        redirect_to mockups_admin_producer_path(params[:id]), notice: "Producteur mis à jour avec succès"
      end
    end
  end
end
