# frozen_string_literal: true

module Mockups
  module Public
    class HomeController < Mockups::Public::BaseController
      def index
        @featured_producers = [
          {
            id: 1,
            name: "Marie Dupont",
            farm_name: "Ferme du Soleil",
            specialty: "Maraîchère Bio",
            city: "Limoges",
            distance: 2.3,
            products_count: 12,
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
            image: "pictures/vobs.studio_Portrait_dune_agricultrice._Elle_porte_une_salopett_33ef692c-abe1-483a-89e1-28b000f76624.png"
          }
        ]

        @featured_products = [
          { id: 1, name: "Tomates Bio", price: 4.50, unit: "kg", producer: "Ferme du Soleil", category: "Légumes", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
          { id: 2, name: "Pommes Gala", price: 2.80, unit: "kg", producer: "Les Vergers du Limousin", category: "Fruits", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
          { id: 3, name: "Fromage de chèvre", price: 8.50, unit: "pièce", producer: "Chèvrerie des Collines", category: "Produits laitiers", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" },
          { id: 4, name: "Œufs Bio", price: 4.00, unit: "douzaine", producer: "Ferme du Soleil", category: "Produits laitiers", image: "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png" }
        ]

        @nearby_markets = mock_markets

        @categories = mock_categories
      end
    end
  end
end
