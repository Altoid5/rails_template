Rails.application.routes.draw do
  # Health check (only include ONCE)
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Homepage
  root "lost_items#index"

  # Your app resources
  resources :lost_items
  resources :found_items
  resources :claims, only: [ :index, :create, :destroy ]
  resources :users, only: [ :show, :edit, :update, :destroy ]
  resources :reports, only: [ :index, :create, :destroy ]
  resources :notifications, only: [ :index, :destroy ]

  # PWA (optional)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
