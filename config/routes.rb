Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  resources :search, only: [:index]
end
