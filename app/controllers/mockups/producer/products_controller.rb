# frozen_string_literal: true

module Mockups
  module Producer
    class ProductsController < BaseController
      def index
        @products = mock_producer_products
        @categories = mock_categories
      end

      def show
        @product = mock_producer_products.find { |p| p[:id] == params[:id].to_i } || mock_producer_products.first
      end

      def new
        @product = {}
        @categories = mock_categories
      end

      def create
        redirect_to mockups_producer_products_path, notice: "Produit créé avec succès"
      end

      def edit
        @product = mock_producer_products.find { |p| p[:id] == params[:id].to_i } || mock_producer_products.first
        @categories = mock_categories
      end

      def update
        redirect_to mockups_producer_products_path, notice: "Produit mis à jour avec succès"
      end

      def destroy
        redirect_to mockups_producer_products_path, notice: "Produit supprimé"
      end
    end
  end
end
