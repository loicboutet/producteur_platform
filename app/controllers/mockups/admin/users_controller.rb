# frozen_string_literal: true

module Mockups
  module Admin
    class UsersController < BaseController
      def index
        @users = mock_admin_users
      end

      def show
        @user = mock_admin_users.find { |u| u[:id] == params[:id].to_i } || mock_admin_users.first
        @recent_orders = mock_admin_orders.select { |o| o[:customer_name] == @user[:name] }
      end

      def edit
        @user = mock_admin_users.find { |u| u[:id] == params[:id].to_i } || mock_admin_users.first
      end

      def update
        redirect_to mockups_admin_user_path(params[:id]), notice: "Utilisateur mis à jour"
      end
    end
  end
end
