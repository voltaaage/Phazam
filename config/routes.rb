Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :users, only: [:index,:show]

  resources :images, only: [:index, :show, :update]
  resources :challenges
end
