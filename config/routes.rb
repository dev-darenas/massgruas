Rails.application.routes.draw do
  resources :vehicles
  resources :clients
  resources :technicals
  resources :manage_users
  resources :transactions

  namespace :transactions do
    resources :clients, only: :new
  end

  devise_for :users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  resources :dashboard, only: :index
end
