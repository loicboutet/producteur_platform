# frozen_string_literal: true

module Mockups
  module Public
    class ProductsController < Mockups::Public::BaseController
      def index
        @products = [
          { id: 1, name: "Tomates Bio", price: 4.50, unit: "kg", stock: 25, available: true, category: "Légumes", producer: "Ferme du Soleil", distance: 2.3 },
          { id: 2, name: "Courgettes", price: 3.20, unit: "kg", stock: 15, available: true, category: "Légumes", producer: "Ferme du Soleil", distance: 2.3 },
          { id: 3, name: "Pommes Gala", price: 2.80, unit: "kg", stock: 50, available: true, category: "Fruits", producer: "Les Vergers du Limousin", distance: 5.1 },
          { id: 4, name: "Fraises", price: 6.50, unit: "barquette", stock: 15, available: true, category: "Fruits", producer: "Les Vergers du Limousin", distance: 5.1 },
          { id: 5, name: "Œufs Bio", price: 4.00, unit: "douzaine", stock: 30, available: true, category: "Produits laitiers", producer: "Ferme du Soleil", distance: 2.3 },
          { id: 6, name: "Fromage de chèvre", price: 8.50, unit: "pièce", stock: 10, available: true, category: "Produits laitiers", producer: "Chèvrerie des Collines", distance: 8.7 },
          { id: 7, name: "Miel de fleurs", price: 12.00, unit: "pot 500g", stock: 20, available: true, category: "Miel & Confitures", producer: "Rucher du Plateau", distance: 4.2 },
          { id: 8, name: "Poulet fermier", price: 15.90, unit: "pièce", stock: 8, available: true, category: "Viandes", producer: "Ferme des Prés", distance: 6.5 }
        ]
        @categories = mock_categories
      end

      def show
        @product = {
          id: params[:id],
          name: "Tomates Bio",
          description: "Tomates cultivées sans pesticides, récoltées à maturité pour un goût incomparable. Variétés anciennes : Cœur de bœuf, Noire de Crimée, Green Zebra.",
          price: 4.50,
          unit: "kg",
          stock: 25,
          available: true,
          category: "Légumes",
          images: [
            "pictures/vobs.studio_httpss.mj.run2yoSBUleddg_Photo_dun_ensemble_de_lg_2c75fed6-bb89-496e-85c3-71561aae6c38_1.png"
          ]
        }
        @producer = mock_producer
        @related_products = mock_products.first(4)
      end
    end
  end
end
