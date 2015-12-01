Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :users, only: [:show, :index]

  resources :images, only: [:index, :show, :update]
  resources :challenges
end
