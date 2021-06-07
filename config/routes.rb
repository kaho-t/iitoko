Rails.application.routes.draw do

  resources :tags, only: [:new, :create, :edit, :update]
  devise_for :locals, controllers: {
    sessions: 'locals/sessions',
    passwords: 'locals/passwords',
    registrations: 'locals/registrations',
    confirmations: 'locals/confirmations'
  }
  get 'locals/:id', to: 'locals#show', as: 'local'

  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
     registrations: "users/registrations",
     confirmations: 'users/confirmations'
    }
  get 'users/:id', to: 'users#show', as: 'user'

  resources :scores, only: [:new, :create, :edit, :update]
  resources :profiles, only: [:new, :create, :edit, :update]
  get '/welcome', to: 'onboadings#welcome'
  get '/top', to: 'recommends#index'
  root 'static_pages#home'
  get 'static_pages/home_local'
  # resources :user_account_activations, only: [:edit]
end
