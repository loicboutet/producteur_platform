Rails.application.routes.draw do
  devise_for :users

  # Stripe webhook
  post "stripe/webhooks", to: "stripe_webhooks#create"

  # Cart (Panier)
  resource :cart, only: [ :show ] do
    post :add_item
    patch :update_item
    delete :remove_item
    delete :clear
  end

  # Checkout (multi-producteurs)
  resource :checkout, only: [ :show, :create ] do
    get :payment
    get :confirm_payment  # Aussi en GET pour la redirection depuis Stripe
    post :confirm_payment
  end

  # Order Groups (groupes de commandes)
  resources :order_groups, only: [ :index, :show ]

  # Producers
  resources :producers, only: [ :new, :create, :show ] do
    collection do
      get :onboarding_refresh
      get :onboarding_complete
    end
    member do
      get :dashboard
      get :stripe_dashboard
    end
  end

  # Alias for dashboard
  get "producer/dashboard", to: "producers#dashboard", as: :producer_dashboard

  # Products
  resources :products do
    # Ancienne route pour compatibilité, mais maintenant on utilise le panier
    resources :orders, only: [ :new, :create ]
  end

  # Orders (anciennes commandes individuelles - à garder pour compatibilité)
  resources :orders, only: [ :index, :show ] do
    member do
      get :payment
      post :confirm_payment
    end
  end

  # ===========================================
  # MOCKUPS ROUTES
  # ===========================================

  namespace :mockups do
    # Index and Styleguide
    get :index
    get :styleguide

    # ===========================================
    # STRUCTURED MOCKUPS BY USER JOURNEY
    # ===========================================

    # Public (visitor) pages
    namespace :public do
      resources :home, only: [ :index ]
      resources :products, only: [ :index, :show ]
      resources :categories, only: [ :index, :show ], param: :slug
      resources :producers, only: [ :index, :show ]
      resources :markets, only: [ :index, :show ]
      resource :cart, only: [ :show ]
      resource :checkout, only: [ :show ] do
        get :payment
        get :success
      end
      resources :become_producer, only: [ :index, :create ] do
        collection do
          get :pending
        end
      end
    end

    # Account (logged-in customer) pages
    namespace :account do
      resource :dashboard, only: [ :show ]
      resource :profile, only: [ :show, :edit, :update ]
      resources :orders, only: [ :index, :show ]
    end

    # Producer pages
    namespace :producer do
      resource :dashboard, only: [ :show ]
      resource :profile, only: [ :show, :edit, :update ]
      resource :stats, only: [ :show ]
      resources :products
      resources :orders, only: [ :index, :show ]
      resources :pickup_points, only: [ :index, :edit, :update ]
      resources :market_presences, only: [ :index, :new, :create, :edit, :update, :destroy ]
      resource :stripe, only: [ :show ], controller: "stripe" do
        get :connect
      end
    end

    # Admin pages
    namespace :admin do
      resource :dashboard, only: [ :show ]
      resources :producers, only: [ :index, :show, :edit, :update ]
      resources :users, only: [ :index, :show, :edit, :update ]
      resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
      resources :markets
      resources :products, only: [ :index, :show ]
      resources :orders, only: [ :index, :show ]
      resources :transactions, only: [ :index, :show ]
      resource :finances, only: [ :show ]
      resource :settings, only: [ :show, :edit, :update ]
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root
  root "products#index"
end
