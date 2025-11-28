# frozen_string_literal: true

module Mockups
  module Admin
    class CategoriesController < BaseController
      def index
        @categories = mock_admin_categories
      end

      def new
        @category = { id: nil, name: "", slug: "", icon: "", position: 1, active: true }
      end

      def create
        redirect_to mockups_admin_categories_path, notice: "Catégorie créée"
      end

      def edit
        @category = mock_admin_categories.find { |c| c[:id] == params[:id].to_i } || mock_admin_categories.first
      end

      def update
        redirect_to mockups_admin_categories_path, notice: "Catégorie mise à jour"
      end

      def destroy
        redirect_to mockups_admin_categories_path, notice: "Catégorie supprimée"
      end
    end
  end
end
