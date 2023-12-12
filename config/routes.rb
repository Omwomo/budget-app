Rails.application.routes.draw do
  get 'home/index'
  resources :groups do
    resources :deals
  end
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get 'home', to: 'home#index', as: :home
  root "home#index"
end
