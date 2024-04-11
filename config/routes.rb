Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations" 
  }

  

  root 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check



  # Equals to below:
  # scope module: :api, path: :api do 
  #   resources :wishlists, only: [:create, :destroy]
  # end
  namespace :api do 
    resources :wishlists, only: [:create, :destroy]
  end

  # TODO: how about singualr resource
  resources :wishlists, only: [:index]

  resources :properties, only: [:show, :index] do
    resources :bookings, only: [:new]
  end

  resources :booking_payments, only: [:create]

  get '/reviews/:id/full', to: 'reviews#show_more', as: 'reviews_show_more'

  get "booking_payments/success", to: "booking_payments#success"

  resource :profile, only: [:edit, :update]
  resolve('Profile') { [:profile] }

  resources :reservations, only: [:index] do 
    resources :reviews, only: [:new, :create]
  end
end
