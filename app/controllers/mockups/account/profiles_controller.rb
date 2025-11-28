# frozen_string_literal: true

module Mockups
  module Account
    class ProfilesController < Mockups::Account::BaseController
      def show
        @user = mock_current_user
      end

      def edit
        @user = mock_current_user
      end

      def update
        redirect_to mockups_account_profile_path, notice: "Profil mis à jour avec succès"
      end
    end
  end
end
