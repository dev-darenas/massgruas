Rails.application.routes.draw do
  resources :vehicles
  resources :clients
  resources :manage_users

  devise_for :users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  resources :dashboard, only: :index
end
