# Spécification des Mockups - Marketplace Producteurs Locaux

> Ce document définit les instructions pour la création des mockups de l'application.
> Les mockups sont des vues statiques permettant de valider l'UX/UI avant l'implémentation complète.

---

## 🎯 Objectif

Créer les mockups de toutes les pages de l'application définies dans `doc/routes.md`.

**Tu fais UNIQUEMENT des mockups** : controllers et views statiques. Pas de logique métier, pas de modèles, pas de services.

---

## 📋 Règles strictes

### 1. Namespace et préfixe obligatoires

**TOUTES les routes de mockups doivent :**
- Être dans le namespace `mockups`
- Avoir le préfixe `/mockups/` dans l'URL

```ruby
# ✅ CORRECT
namespace :mockups do
  namespace :public do
    resources :products, only: [:index, :show]
  end
  
  namespace :account do
    resource :dashboard, only: [:show]
  end
  
  namespace :producer do
    resources :products
  end
  
  namespace :admin do
    resources :producers
  end
end

# URL générées :
# /mockups/public/products
# /mockups/account/dashboard
# /mockups/producer/products
# /mockups/admin/producers
```

### 2. Structure des fichiers

```
app/
├── controllers/
│   └── mockups/
│       ├── base_controller.rb
│       ├── public/
│       │   ├── home_controller.rb
│       │   ├── products_controller.rb
│       │   ├── categories_controller.rb
│       │   ├── producers_controller.rb
│       │   ├── markets_controller.rb
│       │   ├── cart_controller.rb
│       │   └── checkout_controller.rb
│       ├── account/
│       │   ├── dashboard_controller.rb
│       │   ├── profile_controller.rb
│       │   └── orders_controller.rb
│       ├── producer/
│       │   ├── dashboard_controller.rb
│       │   ├── profile_controller.rb
│       │   ├── products_controller.rb
│       │   ├── orders_controller.rb
│       │   ├── pickup_points_controller.rb
│       │   ├── market_presences_controller.rb
│       │   ├── stripe_controller.rb
│       │   └── stats_controller.rb
│       └── admin/
│           ├── dashboard_controller.rb
│           ├── producers_controller.rb
│           ├── users_controller.rb
│           ├── categories_controller.rb
│           ├── markets_controller.rb
│           ├── products_controller.rb
│           ├── orders_controller.rb
│           ├── transactions_controller.rb
│           ├── finances_controller.rb
│           └── settings_controller.rb
└── views/
    └── mockups/
        ├── public/
        │   ├── home/
        │   ├── products/
        │   ├── categories/
        │   ├── producers/
        │   ├── markets/
        │   ├── cart/
        │   └── checkout/
        ├── account/
        │   ├── dashboard/
        │   ├── profile/
        │   └── orders/
        ├── producer/
        │   ├── dashboard/
        │   ├── profile/
        │   ├── products/
        │   ├── orders/
        │   ├── pickup_points/
        │   ├── market_presences/
        │   ├── stripe/
        │   └── stats/
        └── admin/
            ├── dashboard/
            ├── producers/
            ├── users/
            ├── categories/
            ├── markets/
            ├── products/
            ├── orders/
            ├── transactions/
            ├── finances/
            └── settings/
```

### 3. Principes KISS & REST

- **KISS** : Vues simples, données mockées en dur dans les controllers
- **REST** : Respecter les actions standard (index, show, new, edit, etc.)
- **Pas de logique métier** : Juste de l'affichage
- **Données fictives** : Utiliser des hashes/arrays dans les controllers

```ruby
# Exemple de controller mockup
module Mockups
  module Producer
    class ProductsController < Mockups::BaseController
      def index
        @products = [
          { id: 1, name: "Tomates Bio", price: 4.50, stock: 25, available: true },
          { id: 2, name: "Courgettes", price: 3.20, stock: 0, available: false },
          { id: 3, name: "Pommes Gala", price: 2.80, stock: 50, available: true }
        ]
      end
      
      def show
        @product = { id: 1, name: "Tomates Bio", price: 4.50, stock: 25, description: "Tomates cultivées sans pesticides" }
      end
      
      def new
        @product = {}
      end
      
      def edit
        @product = { id: 1, name: "Tomates Bio", price: 4.50, stock: 25 }
      end
    end
  end
end
```

### 4. Respecter le Style Guide

Toutes les vues **DOIVENT** respecter le style guide existant :
- Voir `doc/design_guide.html`
- Utiliser Tailwind CSS
- Composants UI cohérents
- Mobile-first / Responsive

### 5. Layouts par namespace

```ruby
# app/controllers/mockups/base_controller.rb
module Mockups
  class BaseController < ApplicationController
    layout 'mockups/application'
  end
end

# app/controllers/mockups/public/base_controller.rb
module Mockups
  module Public
    class BaseController < Mockups::BaseController
      layout 'mockups/public'
    end
  end
end

# app/controllers/mockups/account/base_controller.rb
module Mockups
  module Account
    class BaseController < Mockups::BaseController
      layout 'mockups/account'
    end
  end
end

# app/controllers/mockups/producer/base_controller.rb
module Mockups
  module Producer
    class BaseController < Mockups::BaseController
      layout 'mockups/producer'
    end
  end
end

# app/controllers/mockups/admin/base_controller.rb
module Mockups
  module Admin
    class BaseController < Mockups::BaseController
      layout 'mockups/admin'
    end
  end
end
```

---

## 📍 Fichier de suivi des progrès

**Tu DOIS créer et maintenir à jour le fichier : `doc/mockups_progress.md`**

Ce fichier doit tracker :
- ✅ Pages terminées
- 🔄 Pages en cours
- ⬜ Pages à faire

Mettre à jour ce fichier **après chaque page complétée**.

### Format du fichier de progrès

```markdown
# Progrès des Mockups

Dernière mise à jour : [DATE]

## Résumé
- Total pages : XX
- Terminées : XX (XX%)
- En cours : XX
- À faire : XX

## Public (XX/XX)
- ✅ Home - index
- ✅ Products - index
- 🔄 Products - show
- ⬜ Categories - index
...

## Account (XX/XX)
...

## Producer (XX/XX)
...

## Admin (XX/XX)
...
```

---

## 🗺️ Pages à créer (référence : doc/routes.md)

### Public (~15 pages)

| Route | Action | Page |
|-------|--------|------|
| `/mockups/public` | index | Page d'accueil avec géolocalisation |
| `/mockups/public/products` | index | Liste des produits |
| `/mockups/public/products/:id` | show | Détail d'un produit |
| `/mockups/public/categories` | index | Liste des catégories |
| `/mockups/public/categories/:slug` | show | Produits d'une catégorie |
| `/mockups/public/producers` | index | Liste/carte des producteurs |
| `/mockups/public/producers/:id` | show | Profil public producteur |
| `/mockups/public/markets` | index | Liste/carte des marchés |
| `/mockups/public/markets/:id` | show | Détail marché + producteurs |
| `/mockups/public/cart` | show | Panier |
| `/mockups/public/checkout` | show | Récap + choix point retrait |
| `/mockups/public/checkout/payment` | payment | Page paiement Stripe |
| `/mockups/public/checkout/success` | success | Confirmation commande |
| `/mockups/public/become_producer` | new | Formulaire inscription producteur |
| `/mockups/public/become_producer/pending` | pending | Page attente validation |

### Account (~5 pages)

| Route | Action | Page |
|-------|--------|------|
| `/mockups/account` | show | Dashboard client |
| `/mockups/account/profile` | show | Mon profil |
| `/mockups/account/profile/edit` | edit | Éditer profil |
| `/mockups/account/orders` | index | Mes commandes |
| `/mockups/account/orders/:id` | show | Détail commande |

### Producer (~20 pages)

| Route | Action | Page |
|-------|--------|------|
| `/mockups/producer` | show | Dashboard producteur |
| `/mockups/producer/profile` | show | Mon profil producteur |
| `/mockups/producer/profile/edit` | edit | Éditer profil |
| `/mockups/producer/stats` | show | Statistiques |
| `/mockups/producer/products` | index | Liste mes produits |
| `/mockups/producer/products/new` | new | Nouveau produit |
| `/mockups/producer/products/:id` | show | Voir produit |
| `/mockups/producer/products/:id/edit` | edit | Éditer produit |
| `/mockups/producer/orders` | index | Commandes reçues |
| `/mockups/producer/orders/:id` | show | Détail commande |
| `/mockups/producer/pickup_points` | index | Mes points de retrait |
| `/mockups/producer/pickup_points/new` | new | Nouveau point |
| `/mockups/producer/pickup_points/:id/edit` | edit | Éditer point |
| `/mockups/producer/market_presences` | index | Mes marchés |
| `/mockups/producer/market_presences/new` | new | S'inscrire à un marché |
| `/mockups/producer/market_presences/:id/edit` | edit | Éditer présence |
| `/mockups/producer/stripe` | show | Status Stripe Connect |
| `/mockups/producer/stripe/connect` | connect | Page onboarding Stripe |

### Admin (~25 pages)

| Route | Action | Page |
|-------|--------|------|
| `/mockups/admin` | show | Dashboard admin |
| `/mockups/admin/producers` | index | Liste producteurs |
| `/mockups/admin/producers/:id` | show | Détail producteur |
| `/mockups/admin/producers/:id/edit` | edit | Éditer producteur |
| `/mockups/admin/users` | index | Liste utilisateurs |
| `/mockups/admin/users/:id` | show | Détail utilisateur |
| `/mockups/admin/users/:id/edit` | edit | Éditer utilisateur |
| `/mockups/admin/categories` | index | Liste catégories |
| `/mockups/admin/categories/new` | new | Nouvelle catégorie |
| `/mockups/admin/categories/:id/edit` | edit | Éditer catégorie |
| `/mockups/admin/markets` | index | Liste marchés |
| `/mockups/admin/markets/new` | new | Nouveau marché |
| `/mockups/admin/markets/:id` | show | Détail marché |
| `/mockups/admin/markets/:id/edit` | edit | Éditer marché |
| `/mockups/admin/products` | index | Liste tous produits |
| `/mockups/admin/products/:id` | show | Détail produit |
| `/mockups/admin/orders` | index | Liste commandes |
| `/mockups/admin/orders/:id` | show | Détail commande |
| `/mockups/admin/transactions` | index | Liste transactions |
| `/mockups/admin/transactions/:id` | show | Détail transaction |
| `/mockups/admin/finances` | show | Vue finances |
| `/mockups/admin/settings` | show | Configuration |
| `/mockups/admin/settings/edit` | edit | Éditer configuration |

---

## 🚀 Ordre d'exécution

**Procéder par user journey, dans cet ordre :**

### Phase 1 : Public (Visiteur)
1. Home (géolocalisation)
2. Catalogue produits (index, show)
3. Catégories (index, show)
4. Producteurs (index, show)
5. Marchés (index, show)
6. Panier
7. Checkout (show, payment, success)
8. Inscription producteur

### Phase 2 : Account (Client connecté)
1. Dashboard
2. Profil (show, edit)
3. Commandes (index, show)

### Phase 3 : Producer (Producteur)
1. Dashboard
2. Profil (show, edit)
3. Produits (CRUD complet)
4. Commandes (index, show avec actions)
5. Points de retrait (CRUD)
6. Présence marchés (CRUD)
7. Stripe Connect
8. Statistiques

### Phase 4 : Admin (Back-office)
1. Dashboard
2. Producteurs (validation, modération)
3. Utilisateurs
4. Catégories
5. Marchés
6. Produits (modération)
7. Commandes
8. Transactions & Finances
9. Configuration

---

## 📌 Index des mockups

**Conserver et enrichir la page index existante** : `/mockups`

Cette page doit présenter :
- Tous les user journeys
- Liens vers chaque mockup
- Status (fait / à faire)

```ruby
# Route existante à conserver
namespace :mockups do
  get '/', to: 'index#show', as: :root
end
```

---

## ⚠️ Rappels importants

1. **Ne PAS inclure** ce qui n'est pas dans les specs
2. **Respecter** le style guide (`doc/design_guide.html`)
3. **Mettre à jour** `doc/mockups_progress.md` après chaque page
4. **Toutes les routes** sous `/mockups/`
5. **Données mockées** dans les controllers (pas de DB)
6. **KISS** : Simple, lisible, maintenable

---

## 🏁 Go!

1. Créer `doc/mockups_progress.md`
2. Commencer par Phase 1 : Public
3. Mettre à jour le progrès régulièrement
4. Maintenir l'index `/mockups` à jour
