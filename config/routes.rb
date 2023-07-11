Rails.application.routes.draw do
  resources :wallets, only: [:index]
  resources :teams, only: [:index]
  resources :stocks, only: [:index, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'home', to: 'home#index'
  get 'transactions', to: 'transactions#new'
  post 'transactions', to: 'transactions#create'

  root "home#index"
end
