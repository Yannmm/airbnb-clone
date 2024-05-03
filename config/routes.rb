Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations" 
  }

  

  root 'home#index'

  get '/home/search', to: "home#search"

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

  resources :properties, only: [:show] do
    resource :wishlist, only: [:update], module: :properties
    resources :bookings, only: [:new]
    member do 
      get 'description'
      get 'share'
      get 'ensemble'
      get 'repertoire'
    end
  end

  resources :booking_payments, only: [:create]

  get '/reviews/:id/full', to: 'reviews#show_more', as: 'reviews_show_more'

  get "/booking_payments/success", to: "booking_payments#success"

  get "/search", to: "search#index"

  resource :profile, only: [:edit, :update]
  resolve('Profile') { [:profile] }

  resource :email, only: [:edit, :update]
  resolve('Email') { [:email] }

  resource :password, only: [:edit, :update]
  resolve('Password') { [:password] }

  resources :reservations, only: [:index] do 
    resources :reviews, only: [:new, :create]
  end

  namespace :owner do 
    resource :dashboard, only: [:show]

    resources :reservations, only: [:index]

    resources :properties do 
      member do 
        patch 'furnish'
        delete 'detach/:image_id', :action => 'detach', as: 'detach'
        patch 'attach'
        patch 'locate'
      end
    end
  end
end
