Rails.application.routes.draw do
  get "map/index"
  resources :posts
  get 'latest', to: 'posts#latest'
  get "up" => "rails/health#show", as: :rails_health_check
  get "/map", to: "map#index"
  get "/guest_login", to: "sessions#guest"
  # Devise
  devise_for :users, skip: [:sessions]
  as :user do
    # Don't use Devise login — use custom email login
    get "/users/sign_in" => redirect("/email_login")
  end

  # UTRGV Email Login Routes
  get  "/email_login",  to: "email_codes#new"
  post "/email_login",  to: "email_codes#create"
  get  "/verify_code",  to: "email_codes#verify"
  post "/verify_code",  to: "email_codes#verify"

  resources :email_codes, only: [:new, :create]

  authenticated :user do
    root to: "lost_items#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "email_codes#new", as: :unauthenticated_root
  end

  # Main app resources
  resources :lost_items
  resources :posts
  resources :found_items
  resources :claims, only: [:index, :create, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :reports, only: [:index, :create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
