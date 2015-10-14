Rails.application.routes.draw do
  devise_for :users
    resources :users, only: [:update, :create, :index]
  root to: 'welcome#index'
end
