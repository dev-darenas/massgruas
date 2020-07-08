Rails.application.routes.draw do
  resources :vehicles
  resources :clients
  resources :technicals
  resources :manage_users
  resources :transactions
  get '/transactions/close/:id', to: 'transactions#close', as: 'transaction_close'

  namespace :transactions do
    resources :clients, only: :new
    resources :vehicles, only: :new
    resources :technicals, only: :new
  end

  devise_for :users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  resources :dashboard, only: :index
end
