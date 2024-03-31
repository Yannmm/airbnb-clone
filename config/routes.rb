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

  # TODO: check nested resources
  resources :properties, only: [:show, :index] do
    resources :bookings, only: [:new]
  end

  

  get '/reviews/:id/full', to: 'reviews#show_more', as: 'reviews_show_more'

end
