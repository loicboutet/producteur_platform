# frozen_string_literal: true

module Mockups
  module Public
    class BecomeProducerController < Mockups::Public::BaseController
      def index
        # Registration form page
      end

      def create
        # This would normally create a producer account
        redirect_to pending_mockups_public_become_producer_index_path
      end

      def pending
        # Pending validation page
      end
    end
  end
end
