Rails.application.routes.draw do
  resources :accounts
  resources :services
  resources :document_types
  resources :manage_users
  resources :transactions
  resources :enterprises

  resources :vehicles do
    scope module: :vehicles do
      resources :documents
    end
  end

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
  get '/transactions/deliver/:id', to: 'transactions#deliver', as: 'transaction_deliver'
  get '/transactions/check_in/:id', to: 'transactions#check_in', as: 'transaction_check_in'

  namespace :transactions do
    resources :clients, only: :new
    resources :vehicles, only: :new
    resources :technicals, only: :new
    resources :accounts, only: :new
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

  get 'reports/technical_payment', as: 'technical_payment'
  get 'reports/technical_clearance', as: 'technical_clearance'
  get 'reports/payment_per_vehicle', as: 'payment_per_vehicle'
  get 'reports/vehicle_liquidation', as: 'vehicle_liquidation'
  get 'reports/transaction_report', as: 'transaction_report'
  get 'reports/service_report', as: 'service_report'

end
