Rails.application.routes.draw do
  get 'bills/index'
  get 'bills/new'
  get 'bill/index'
  get 'bill/new'
  root to: "bills#index"
  resources :items
  resources :bills, only: [:index,:new,:create, :show]
  devise_for :users
end
