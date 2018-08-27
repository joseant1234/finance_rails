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

  resources :teams, except: [:show, :destroy] do
    member do
      put 'status'
    end
    resources :collaborators, shallow: true, except: [:destroy]
  end

  resources :collaborators, only: [] do
    put 'status', on: :member
  end

  resources :expenses, except: [:destroy] do
    collection do
      get 'provider_information'
      get 'collaborators_information'
    end
    member do
      put 'pay'
      get 'download'
    end
    resources :fees, shallow: true, except: [:destroy]
  end

  resources :incomes, except: [:destroy] do
    collection do
      get 'client_information'
    end
    member do
      get 'download'
      get 'generate_invoice'
    end
  end

  resources :parameters, except: [:new, :create, :destroy]

  resources :categories, except: [:destroy] do
    member do
      put 'status'
    end
  end
end
