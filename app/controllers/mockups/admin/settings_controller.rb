# frozen_string_literal: true

module Mockups
  module Admin
    class SettingsController < BaseController
      def show
        @settings = mock_settings
      end

      def edit
        @settings = mock_settings
      end

      def update
        redirect_to mockups_admin_settings_path, notice: "Configuration mise à jour"
      end
    end
  end
end
