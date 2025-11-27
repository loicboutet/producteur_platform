# Documentation des Routes - Marketplace Producteurs Locaux

> Ce document définit toutes les routes de l'application, organisées par namespace/profil utilisateur.
> Principes : REST, KISS, namespaces par rôle.

---

## Vue d'ensemble des namespaces

| Namespace | Description | Authentification |
|-----------|-------------|------------------|
| `/` | Routes publiques (catalogue, pages statiques) | Non |
| `/account` | Espace client (commandes, profil) | Oui (customer) |
| `/producer` | Espace producteur (produits, commandes, dashboard) | Oui (producer) |
| `/admin` | Back-office administration | Oui (admin) |
| `/api/v1` | API REST (future) | Token |

---

## Routes Publiques (sans namespace)

### Authentification (Devise)

```ruby
# Générées par Devise
devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
}

# Routes générées :
# GET    /users/sign_in          => sessions#new
# POST   /users/sign_in          => sessions#create
# DELETE /users/sign_out         => sessions#destroy
# GET    /users/sign_up          => registrations#new
# POST   /users                  => registrations#create
# GET    /users/edit             => registrations#edit
# PATCH  /users                  => registrations#update
# GET    /users/password/new     => passwords#new
# POST   /users/password         => passwords#create
# GET    /users/password/edit    => passwords#edit
# PATCH  /users/password         => passwords#update
```

### Catalogue & Pages publiques

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/` | `home#index` | Page d'accueil avec géolocalisation |
| GET | `/products` | `products#index` | Liste des produits (filtres, recherche) |
| GET | `/products/:id` | `products#show` | Détail d'un produit |
| GET | `/categories` | `categories#index` | Liste des catégories |
| GET | `/categories/:slug` | `categories#show` | Produits d'une catégorie |
| GET | `/producers` | `producers#index` | Liste des producteurs (carte/liste) |
| GET | `/producers/:id` | `producers#show` | Profil public d'un producteur |
| GET | `/markets` | `markets#index` | Liste des marchés (carte/liste) |
| GET | `/markets/:id` | `markets#show` | Détail d'un marché + producteurs présents |

```ruby
# config/routes.rb
root "home#index"

resources :products, only: [:index, :show]
resources :categories, only: [:index, :show], param: :slug
resources :producers, only: [:index, :show]
resources :markets, only: [:index, :show]
```

### Panier (session-based)

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/cart` | `cart#show` | Afficher le panier |
| POST | `/cart/items` | `cart#add_item` | Ajouter un produit |
| PATCH | `/cart/items/:id` | `cart#update_item` | Modifier quantité |
| DELETE | `/cart/items/:id` | `cart#remove_item` | Supprimer un article |
| DELETE | `/cart` | `cart#clear` | Vider le panier |

```ruby
resource :cart, only: [:show, :destroy] do
  resources :items, controller: 'cart_items', only: [:create, :update, :destroy]
end
```

### Checkout (peut être invité ou connecté)

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/checkout` | `checkout#show` | Récap panier + choix points de retrait |
| POST | `/checkout` | `checkout#create` | Valider et créer OrderGroup |
| GET | `/checkout/payment` | `checkout#payment` | Page de paiement Stripe |
| POST | `/checkout/confirm` | `checkout#confirm` | Confirmer le paiement |
| GET | `/checkout/success` | `checkout#success` | Confirmation de commande |

```ruby
resource :checkout, only: [:show, :create] do
  get :payment
  post :confirm
  get :success
end
```

### Inscription Producteur (public)

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/become-producer` | `producer_registrations#new` | Formulaire d'inscription |
| POST | `/become-producer` | `producer_registrations#create` | Soumettre candidature |
| GET | `/become-producer/pending` | `producer_registrations#pending` | Page "en attente de validation" |

```ruby
resource :producer_registration, only: [:new, :create], path: 'become-producer' do
  get :pending
end
```

### Webhooks

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| POST | `/webhooks/stripe` | `webhooks/stripe#create` | Webhook Stripe |

```ruby
namespace :webhooks do
  post 'stripe', to: 'stripe#create'
end
```

---

## Namespace `/account` (Espace Client)

> Accessible aux utilisateurs connectés (rôle: customer ou producer)

### Préfixe : `/account`

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/account` | `account/dashboard#show` | Dashboard client |
| GET | `/account/profile` | `account/profile#show` | Mon profil |
| GET | `/account/profile/edit` | `account/profile#edit` | Éditer profil |
| PATCH | `/account/profile` | `account/profile#update` | Sauvegarder profil |
| GET | `/account/orders` | `account/orders#index` | Mes commandes |
| GET | `/account/orders/:id` | `account/orders#show` | Détail d'une commande |

```ruby
namespace :account do
  get '/', to: 'dashboard#show', as: :dashboard
  
  resource :profile, only: [:show, :edit, :update]
  resources :orders, only: [:index, :show]
end
```

---

## Namespace `/producer` (Espace Producteur)

> Accessible aux utilisateurs avec rôle `producer` et compte validé

### Préfixe : `/producer`

### Dashboard & Profil

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer` | `producer/dashboard#show` | Dashboard producteur |
| GET | `/producer/profile` | `producer/profile#show` | Mon profil producteur |
| GET | `/producer/profile/edit` | `producer/profile#edit` | Éditer profil |
| PATCH | `/producer/profile` | `producer/profile#update` | Sauvegarder profil |

### Produits

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/products` | `producer/products#index` | Liste mes produits |
| GET | `/producer/products/new` | `producer/products#new` | Nouveau produit |
| POST | `/producer/products` | `producer/products#create` | Créer produit |
| GET | `/producer/products/:id` | `producer/products#show` | Voir produit |
| GET | `/producer/products/:id/edit` | `producer/products#edit` | Éditer produit |
| PATCH | `/producer/products/:id` | `producer/products#update` | Mettre à jour produit |
| DELETE | `/producer/products/:id` | `producer/products#destroy` | Supprimer produit |
| PATCH | `/producer/products/:id/toggle` | `producer/products#toggle` | Activer/désactiver |

### Commandes

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/orders` | `producer/orders#index` | Commandes reçues |
| GET | `/producer/orders/:id` | `producer/orders#show` | Détail commande |
| PATCH | `/producer/orders/:id/ready` | `producer/orders#mark_ready` | Marquer "prêt à retirer" |
| PATCH | `/producer/orders/:id/picked_up` | `producer/orders#mark_picked_up` | Confirmer retrait |

### Points de retrait

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/pickup_points` | `producer/pickup_points#index` | Mes points de retrait |
| GET | `/producer/pickup_points/new` | `producer/pickup_points#new` | Nouveau point |
| POST | `/producer/pickup_points` | `producer/pickup_points#create` | Créer point |
| GET | `/producer/pickup_points/:id/edit` | `producer/pickup_points#edit` | Éditer point |
| PATCH | `/producer/pickup_points/:id` | `producer/pickup_points#update` | Mettre à jour |
| DELETE | `/producer/pickup_points/:id` | `producer/pickup_points#destroy` | Supprimer |

### Créneaux horaires (nested sous pickup_points)

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| POST | `/producer/pickup_points/:id/schedules` | `producer/pickup_schedules#create` | Ajouter créneau |
| PATCH | `/producer/pickup_points/:id/schedules/:schedule_id` | `producer/pickup_schedules#update` | Modifier créneau |
| DELETE | `/producer/pickup_points/:id/schedules/:schedule_id` | `producer/pickup_schedules#destroy` | Supprimer créneau |

### Présence sur marchés

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/market_presences` | `producer/market_presences#index` | Mes marchés |
| GET | `/producer/market_presences/new` | `producer/market_presences#new` | S'inscrire à un marché |
| POST | `/producer/market_presences` | `producer/market_presences#create` | Confirmer inscription |
| GET | `/producer/market_presences/:id/edit` | `producer/market_presences#edit` | Éditer présence |
| PATCH | `/producer/market_presences/:id` | `producer/market_presences#update` | Mettre à jour |
| DELETE | `/producer/market_presences/:id` | `producer/market_presences#destroy` | Se désinscrire |

### Stripe Connect

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/stripe` | `producer/stripe#show` | Status compte Stripe |
| POST | `/producer/stripe/connect` | `producer/stripe#connect` | Démarrer onboarding |
| GET | `/producer/stripe/refresh` | `producer/stripe#refresh` | Refresh onboarding |
| GET | `/producer/stripe/return` | `producer/stripe#return` | Retour après onboarding |
| GET | `/producer/stripe/dashboard` | `producer/stripe#dashboard` | Accès dashboard Stripe |

### Statistiques

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/producer/stats` | `producer/stats#show` | Statistiques de vente |

```ruby
namespace :producer do
  get '/', to: 'dashboard#show', as: :dashboard
  
  resource :profile, only: [:show, :edit, :update]
  resource :stats, only: [:show]
  
  resources :products do
    member do
      patch :toggle
    end
  end
  
  resources :orders, only: [:index, :show] do
    member do
      patch :mark_ready
      patch :mark_picked_up
    end
  end
  
  resources :pickup_points, except: [:show] do
    resources :schedules, controller: 'pickup_schedules', only: [:create, :update, :destroy]
  end
  
  resources :market_presences, except: [:show]
  
  resource :stripe, controller: 'stripe', only: [:show] do
    post :connect
    get :refresh
    get :return
    get :dashboard
  end
end
```

---

## Namespace `/admin` (Back-office)

> Accessible uniquement aux utilisateurs avec rôle `admin`

### Préfixe : `/admin`

### Dashboard

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin` | `admin/dashboard#show` | Dashboard admin |

### Gestion des producteurs

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/producers` | `admin/producers#index` | Liste producteurs |
| GET | `/admin/producers/:id` | `admin/producers#show` | Détail producteur |
| GET | `/admin/producers/:id/edit` | `admin/producers#edit` | Éditer producteur |
| PATCH | `/admin/producers/:id` | `admin/producers#update` | Mettre à jour |
| DELETE | `/admin/producers/:id` | `admin/producers#destroy` | Supprimer |
| PATCH | `/admin/producers/:id/validate` | `admin/producers#validate` | Valider compte |
| PATCH | `/admin/producers/:id/reject` | `admin/producers#reject` | Rejeter compte |
| PATCH | `/admin/producers/:id/suspend` | `admin/producers#suspend` | Suspendre compte |

### Gestion des utilisateurs

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/users` | `admin/users#index` | Liste utilisateurs |
| GET | `/admin/users/:id` | `admin/users#show` | Détail utilisateur |
| GET | `/admin/users/:id/edit` | `admin/users#edit` | Éditer utilisateur |
| PATCH | `/admin/users/:id` | `admin/users#update` | Mettre à jour |
| DELETE | `/admin/users/:id` | `admin/users#destroy` | Supprimer |

### Gestion des catégories

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/categories` | `admin/categories#index` | Liste catégories |
| GET | `/admin/categories/new` | `admin/categories#new` | Nouvelle catégorie |
| POST | `/admin/categories` | `admin/categories#create` | Créer catégorie |
| GET | `/admin/categories/:id/edit` | `admin/categories#edit` | Éditer catégorie |
| PATCH | `/admin/categories/:id` | `admin/categories#update` | Mettre à jour |
| DELETE | `/admin/categories/:id` | `admin/categories#destroy` | Supprimer |
| PATCH | `/admin/categories/:id/move` | `admin/categories#move` | Réordonner |

### Gestion des marchés

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/markets` | `admin/markets#index` | Liste marchés |
| GET | `/admin/markets/new` | `admin/markets#new` | Nouveau marché |
| POST | `/admin/markets` | `admin/markets#create` | Créer marché |
| GET | `/admin/markets/:id` | `admin/markets#show` | Détail marché |
| GET | `/admin/markets/:id/edit` | `admin/markets#edit` | Éditer marché |
| PATCH | `/admin/markets/:id` | `admin/markets#update` | Mettre à jour |
| DELETE | `/admin/markets/:id` | `admin/markets#destroy` | Supprimer |

### Modération produits

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/products` | `admin/products#index` | Liste tous produits |
| GET | `/admin/products/:id` | `admin/products#show` | Détail produit |
| PATCH | `/admin/products/:id/approve` | `admin/products#approve` | Approuver |
| PATCH | `/admin/products/:id/reject` | `admin/products#reject` | Rejeter |
| DELETE | `/admin/products/:id` | `admin/products#destroy` | Supprimer |

### Gestion des commandes

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/orders` | `admin/orders#index` | Liste commandes |
| GET | `/admin/orders/:id` | `admin/orders#show` | Détail commande |
| PATCH | `/admin/orders/:id/refund` | `admin/orders#refund` | Rembourser |

### Transactions & Finances

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/transactions` | `admin/transactions#index` | Liste transactions |
| GET | `/admin/transactions/:id` | `admin/transactions#show` | Détail transaction |
| GET | `/admin/finances` | `admin/finances#show` | Vue finances globale |
| GET | `/admin/finances/export` | `admin/finances#export` | Export comptable (CSV) |

### Configuration plateforme

| Méthode | Route | Controller#Action | Description |
|---------|-------|-------------------|-------------|
| GET | `/admin/settings` | `admin/settings#show` | Configuration |
| PATCH | `/admin/settings` | `admin/settings#update` | Sauvegarder config |

```ruby
namespace :admin do
  get '/', to: 'dashboard#show', as: :dashboard
  
  resources :producers, except: [:new, :create] do
    member do
      patch :validate
      patch :reject
      patch :suspend
    end
  end
  
  resources :users, except: [:new, :create]
  
  resources :categories, except: [:show] do
    member do
      patch :move
    end
  end
  
  resources :markets
  
  resources :products, only: [:index, :show, :destroy] do
    member do
      patch :approve
      patch :reject
    end
  end
  
  resources :orders, only: [:index, :show] do
    member do
      patch :refund
    end
  end
  
  resources :transactions, only: [:index, :show]
  
  resource :finances, only: [:show] do
    get :export
  end
  
  resource :settings, only: [:show, :update]
end
```

---

## Fichier routes.rb complet

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # === DEVISE ===
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # === WEBHOOKS ===
  namespace :webhooks do
    post 'stripe', to: 'stripe#create'
  end

  # === PUBLIC ROUTES ===
  root "home#index"
  
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show], param: :slug
  resources :producers, only: [:index, :show]
  resources :markets, only: [:index, :show]
  
  # Cart (session-based)
  resource :cart, only: [:show, :destroy] do
    resources :items, controller: 'cart_items', only: [:create, :update, :destroy]
  end
  
  # Checkout
  resource :checkout, only: [:show, :create] do
    get :payment
    post :confirm
    get :success
  end
  
  # Producer registration (public)
  resource :producer_registration, only: [:new, :create], path: 'become-producer' do
    get :pending
  end

  # === ACCOUNT NAMESPACE (Customer) ===
  namespace :account do
    get '/', to: 'dashboard#show', as: :dashboard
    
    resource :profile, only: [:show, :edit, :update]
    resources :orders, only: [:index, :show]
  end

  # === PRODUCER NAMESPACE ===
  namespace :producer do
    get '/', to: 'dashboard#show', as: :dashboard
    
    resource :profile, only: [:show, :edit, :update]
    resource :stats, only: [:show]
    
    resources :products do
      member do
        patch :toggle
      end
    end
    
    resources :orders, only: [:index, :show] do
      member do
        patch :mark_ready
        patch :mark_picked_up
      end
    end
    
    resources :pickup_points, except: [:show] do
      resources :schedules, controller: 'pickup_schedules', only: [:create, :update, :destroy]
    end
    
    resources :market_presences, except: [:show]
    
    resource :stripe, controller: 'stripe', only: [:show] do
      post :connect
      get :refresh
      get :return
      get :dashboard
    end
  end

  # === ADMIN NAMESPACE ===
  namespace :admin do
    get '/', to: 'dashboard#show', as: :dashboard
    
    resources :producers, except: [:new, :create] do
      member do
        patch :validate
        patch :reject
        patch :suspend
      end
    end
    
    resources :users, except: [:new, :create]
    
    resources :categories, except: [:show] do
      member do
        patch :move
      end
    end
    
    resources :markets
    
    resources :products, only: [:index, :show, :destroy] do
      member do
        patch :approve
        patch :reject
      end
    end
    
    resources :orders, only: [:index, :show] do
      member do
        patch :refund
      end
    end
    
    resources :transactions, only: [:index, :show]
    
    resource :finances, only: [:show] do
      get :export
    end
    
    resource :settings, only: [:show, :update]
  end

  # === HEALTH CHECK ===
  get "up" => "rails/health#show", as: :rails_health_check
end
```

---

## Contraintes & Middleware

### Authentification par namespace

```ruby
# app/controllers/account/base_controller.rb
module Account
  class BaseController < ApplicationController
    before_action :authenticate_user!
  end
end

# app/controllers/producer/base_controller.rb
module Producer
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_producer!
    
    private
    
    def require_producer!
      unless current_user.producer?
        redirect_to root_path, alert: "Accès réservé aux producteurs"
      end
    end
  end
end

# app/controllers/admin/base_controller.rb
module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    
    private
    
    def require_admin!
      unless current_user.admin?
        redirect_to root_path, alert: "Accès réservé aux administrateurs"
      end
    end
  end
end
```

---

## Récapitulatif des routes par rôle

| Rôle | Namespace | Nombre de routes | Accès |
|------|-----------|------------------|-------|
| Public | `/` | ~20 | Tout le monde |
| Customer | `/account` | ~6 | Utilisateur connecté |
| Producer | `/producer` | ~25 | Producteur validé |
| Admin | `/admin` | ~35 | Administrateur |

**Total : ~86 routes**

---

## Notes d'implémentation

### Structure des dossiers controllers

```
app/controllers/
├── application_controller.rb
├── home_controller.rb
├── products_controller.rb
├── categories_controller.rb
├── producers_controller.rb
├── markets_controller.rb
├── cart_controller.rb
├── cart_items_controller.rb
├── checkout_controller.rb
├── producer_registrations_controller.rb
├── account/
│   ├── base_controller.rb
│   ├── dashboard_controller.rb
│   ├── profile_controller.rb
│   └── orders_controller.rb
├── producer/
│   ├── base_controller.rb
│   ├── dashboard_controller.rb
│   ├── profile_controller.rb
│   ├── products_controller.rb
│   ├── orders_controller.rb
│   ├── pickup_points_controller.rb
│   ├── pickup_schedules_controller.rb
│   ├── market_presences_controller.rb
│   ├── stripe_controller.rb
│   └── stats_controller.rb
├── admin/
│   ├── base_controller.rb
│   ├── dashboard_controller.rb
│   ├── producers_controller.rb
│   ├── users_controller.rb
│   ├── categories_controller.rb
│   ├── markets_controller.rb
│   ├── products_controller.rb
│   ├── orders_controller.rb
│   ├── transactions_controller.rb
│   ├── finances_controller.rb
│   └── settings_controller.rb
├── users/
│   ├── registrations_controller.rb
│   └── sessions_controller.rb
└── webhooks/
    └── stripe_controller.rb
```

### Helpers de route utiles

```ruby
# Raccourcis pratiques à ajouter
# config/routes.rb (en fin de fichier)

# Redirections pratiques
get '/dashboard', to: redirect { |params, request|
  if request.env['warden'].user&.admin?
    '/admin'
  elsif request.env['warden'].user&.producer?
    '/producer'
  else
    '/account'
  end
}
```
