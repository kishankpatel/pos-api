Rails.application.routes.draw do
  devise_for :users
  root to: "bills#index"
  resources :items
  resources :bills, only: [:index,:new,:create, :show]
end
