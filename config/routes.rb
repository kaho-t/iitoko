Rails.application.routes.draw do
  get '/welcome', to: 'onboadings#welcome'
  get '/donnatoko',to: 'onboadings#edit'
  get '/user/:id', to: 'users#show', as: 'user'
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
