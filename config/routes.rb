Rails.application.routes.draw do
  devise_for :users

  root to: 'providers#index'

  resources :providers, except: [:destroy] do
    member do
      put 'status'
    end
  end
end
