Rails.application.routes.draw do
  root 'home#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get 'trading', to: 'users#show_trade'
      get 'edit-profile'
      patch 'edit-profile', to: 'users#update'
      get 'change-password', to: 'password_change#new'
      post 'change-password', to: 'password_change#create'
    end
  end
  resources :books, only: [:new, :create, :update, :destroy], path_names: { new: 'search' } do
    collection do
      post 'create', to: 'books#create'
    end

    member do
      patch 'trade/open', to: 'books#open_trading'
      patch 'trade/cancel', to: 'books#cancel_trading'
    end
  end
end
