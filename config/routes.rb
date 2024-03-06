Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get "up" => "rails/health#show", as: :rails_health_check


  # Equals to below:
  # scope module: :api, path: :api do 
  #   resources :wishlists, only: [:create, :destroy]
  # end
  namespace :api do 
    resources :wishlists, only: [:create, :destroy]
  end

  resources :properties, only: :show

end
