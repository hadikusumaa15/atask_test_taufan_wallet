Rails.application.routes.draw do
  resources :wallets, only: [:index, :show, :create, :update, :destroy]
  resources :transactions, only: [:create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'home', to: 'home#index'
  get 'wallet', to: 'wallets#index'
  get 'transactions', to: 'transactions#new'
  post 'transactions', to: 'transactions#create'

  root "home#index"
end
