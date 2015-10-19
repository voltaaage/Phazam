Rails.application.routes.draw do
  devise_for :users
    resources :users, only: [:update, :create, :index]

  resources :images, only: [:index, :show, :update]

  root to: 'welcome#index'
end
