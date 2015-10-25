Rails.application.routes.draw do
  devise_for :users
    resources :users, only: [:update, :create, :index]

  resources :images, only: [:index, :show, :update]
  resources :challenges, only: [:index, :new, :update, :destroy]
  root to: 'welcome#index'
end
