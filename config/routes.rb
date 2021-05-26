Rails.application.routes.draw do
  # get '/donnatoko/score', to: 'scores#new'
  # post '/donnatoko/score', to: 'scores#create'
  resources :scores, only: [:new, :create, :edit, :update]
  get '/welcome', to: 'onboadings#welcome'
  get '/user', to: 'users#show', as: 'user'
  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
     registrations: "users/registrations",
     confirmations: 'users/confirmations'
    }
  get '/top', to: 'recommends#index'
  root 'static_pages#home'
  get 'static_pages/home_local'
  # resources :user_account_activations, only: [:edit]
end
