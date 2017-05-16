Rails.application.routes.draw do
  root 'home#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get 'edit-profile'
      patch 'edit-profile', to: 'users#update'
      get 'change-password', to: 'password_change#new'
      post 'change-password', to: 'password_change#create'
    end
  end
end
