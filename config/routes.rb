Rails.application.routes.draw do
  get 'images/index'

  get 'images/show'

  devise_for :users
    resources :users, only: [:update, :create, :index]

  resources :images, only: [:index, :show, :update]

  root to: 'welcome#index'
end
