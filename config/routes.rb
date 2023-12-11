Rails.application.routes.draw do
  resources :groups do
    resources :deals
  end
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "groups#index"
end
