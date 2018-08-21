Rails.application.routes.draw do
  devise_for :users

  root to: 'providers#index'

  resources :providers, except: [:destroy] do
    member do
      put 'status'
    end
  end

  resources :clients, except: [:destroy] do
    member do
      put 'status'
    end
  end

  resources :expenses, except: [:destroy] do
    collection do
      get 'provider_information'
    end
    member do
      put 'pay'
    end
    resources :fees, shallow: true
  end

  resources :incomes, except: [:destroy]
end
