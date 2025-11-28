# frozen_string_literal: true

module Mockups
  module Public
    class MarketsController < Mockups::Public::BaseController
      def index
        @markets = mock_markets
      end

      def show
        @market = mock_market
        @producers = [
          {
            id: 1,
            name: "Marie Dupont",
            farm_name: "Ferme du Soleil",
            specialty: "Maraîchère Bio",
            products_count: 12,
            image: "pictures/vobs.studio_Portrait_dune_agricultrice._Elle_porte_une_salopett_33ef692c-abe1-483a-89e1-28b000f76624.png"
          },
          {
            id: 2,
            name: "Pierre Martin",
            farm_name: "Les Vergers du Limousin",
            specialty: "Arboriculteur",
            products_count: 8,
            image: "pictures/vobs.studio_httpss.mj.run7lD_qg4KZkk_Photo_dun_agriculteur_gr_3f20c55e-4652-48ef-9294-7cb82160678c_0.png"
          }
        ]
      end
    end
  end
end
