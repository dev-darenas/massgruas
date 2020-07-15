Rails.application.routes.draw do
  resources :services
  resources :document_types
  resources :vehicles
  resources :manage_users
  resources :transactions
  resources :technicals do
    scope module: :technicals do
      resources :documents
      resources :bonding_dates
    end
  end
  resources :clients do
    scope module: :clients do
      resources :documents
      resources :list_prices
    end
  end

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

  namespace :api do
    namespace :v1 do
      get 'calulate_distance', to: 'calculate_distance#distance'
    end
  end

end
