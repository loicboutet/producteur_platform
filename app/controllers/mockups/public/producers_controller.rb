# frozen_string_literal: true

module Mockups
  module Public
    class ProducersController < Mockups::Public::BaseController
      def index
        @producers = [
          {
            id: 1,
            name: "Marie Dupont",
            farm_name: "Ferme du Soleil",
            specialty: "Maraîchère Bio",
            city: "Limoges",
            distance: 2.3,
            products_count: 12,
            verified: true,
            image: "pictures/vobs.studio_Portrait_dune_agricultrice._Elle_porte_une_salopett_33ef692c-abe1-483a-89e1-28b000f76624.png"
          },
          {
            id: 2,
            name: "Pierre Martin",
            farm_name: "Les Vergers du Limousin",
            specialty: "Arboriculteur",
            city: "Brive",
            distance: 5.1,
            products_count: 8,
            verified: true,
            image: "pictures/vobs.studio_httpss.mj.run7lD_qg4KZkk_Photo_dun_agriculteur_gr_3f20c55e-4652-48ef-9294-7cb82160678c_0.png"
          },
          {
            id: 3,
            name: "Sophie Leblanc",
            farm_name: "Chèvrerie des Collines",
            specialty: "Fromagère",
            city: "Aurillac",
            distance: 8.7,
            products_count: 6,
            verified: true,
            image: "pictures/vobs.studio_Portrait_dune_agricultrice._Elle_porte_une_salopett_33ef692c-abe1-483a-89e1-28b000f76624.png"
          },
          {
            id: 4,
            name: "Jean Durand",
            farm_name: "Rucher du Plateau",
            specialty: "Apiculteur",
            city: "Tulle",
            distance: 4.2,
            products_count: 5,
            verified: true,
            image: "pictures/vobs.studio_httpss.mj.run7lD_qg4KZkk_Photo_dun_agriculteur_gr_3f20c55e-4652-48ef-9294-7cb82160678c_0.png"
          }
        ]
      end

      def show
        @producer = mock_producer
        @products = mock_products
        @pickup_points = [
          {
            id: 1,
            type: "farm",
            name: "À la ferme",
            address: "123 Route de la Campagne, 87000 Limoges",
            hours: [
              { day: "Lundi - Vendredi", time: "9h00 - 18h00" },
              { day: "Samedi", time: "9h00 - 12h00" }
            ]
          },
          {
            id: 2,
            type: "market",
            name: "Marché de Limoges",
            address: "Place de la Motte, 87000 Limoges",
            hours: [
              { day: "Samedi", time: "8h00 - 13h00" }
            ]
          }
        ]
      end
    end
  end
end
