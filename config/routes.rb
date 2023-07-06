Rails.application.routes.draw do
  resources :wallets, only: [:index, :show, :create, :update, :destroy]
  resources :transactions, only: [:create]
  root "wallets#index"
end
