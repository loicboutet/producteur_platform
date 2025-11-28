# frozen_string_literal: true

# Helper pour les éléments graphiques de la marque Silloun
module SillounHelper
  # Couleurs officielles de la marque
  COLORS = {
    yellow: "#FBE216",
    green: "#005D46",
    white: "#FFFFFF",
    black: "#1a1a1a"
  }.freeze

  # Dimensions originales des images pour calculer les proportions
  # Logo: 2693 x 1001 pixels (ratio ~2.69:1)
  LOGO_ASPECT_RATIO = 2693.0 / 1001.0

  # Chapeau: 501 x 251 pixels (ratio ~2:1)
  CHAPEAU_ASPECT_RATIO = 501.0 / 251.0

  # Logo Silloun
  # Variantes: blanc, jaune, noir, vert
  # Size: hauteur en pixels (la largeur est calculée automatiquement)
  def silloun_logo(variant: :vert, size: nil, class_name: "")
    files = {
      blanc: "silloun-RVB-logo-blanc.png",
      jaune: "silloun-RVB-logo-jaune.png",
      noir: "silloun-RVB-logo-noir.png",
      vert: "silloun-RVB-logo-vert.png"
    }

    file = files[variant.to_sym] || files[:vert]
    options = { alt: "Silloun", class: class_name.presence }

    if size
      height = size.to_i
      width = (height * LOGO_ASPECT_RATIO).round
      options[:width] = width
      options[:height] = height
    end

    image_tag(file, options.compact)
  end

  # Chapeau (couronne) Silloun
  # Variantes: blanc, noir, vert-jaune, vert
  # Size: hauteur en pixels (la largeur est calculée automatiquement)
  def silloun_chapeau(variant: :vert_jaune, size: nil, class_name: "")
    files = {
      blanc: "silloun-RVB-chapeau-blanc.png",
      noir: "silloun-RVB-chapeau-noir.png",
      vert_jaune: "silloun-RVB-chapeau-vert-jaune.png",
      vert: "silloun-RVB-chapeau-vert.png"
    }

    file = files[variant.to_sym] || files[:vert_jaune]
    options = { alt: "Silloun", class: class_name.presence }

    if size
      height = size.to_i
      width = (height * CHAPEAU_ASPECT_RATIO).round
      options[:width] = width
      options[:height] = height
    end

    image_tag(file, options.compact)
  end

  # Cadre Silloun (pour encadrer des photos/contenus)
  # Types: horizontal, vertical-XL, vertical-M, vertical-S, carre-XL, carre-m, carre-S
  def silloun_cadre(type: :carre_m, class_name: "")
    files = {
      horizontal: "silloun-RVB-cadre-horizontal.png",
      vertical_xl: "silloun-RVB-cadre-vertical-XL.png",
      vertical_m: "silloun-RVB-cadre-vertical-M.png",
      vertical_s: "silloun-RVB-cadre-vertical-S.png",
      carre_xl: "silloun-RVB-cadre-carre-XL.png",
      carre_m: "silloun-RVB-cadre-carre-m.png",
      carre_s: "silloun-RVB-cadre-carre-S.png"
    }

    file = files[type.to_sym] || files[:carre_m]

    image_tag(file, alt: "Cadre Silloun", class: class_name)
  end

  # Couleurs de la marque pour référence
  def silloun_colors
    COLORS
  end
end
