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

  # Mockups routes (keeping for reference)
  namespace :mockups do
    get :index
    get :user_dashboard
    get :user_profile
    get :user_settings
    get :admin_dashboard
    get :admin_users
    get :admin_analytics
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root
  root "products#index"
end
