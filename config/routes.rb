Rails.application.routes.draw do
  root to: 'locals#index'

  resources :notifications, only: :index
  resources :tags, only: [:new, :create, :edit, :update]

  devise_for :locals, controllers: {
    sessions: 'locals/sessions',
    passwords: 'locals/passwords',
    registrations: 'locals/registrations',
    confirmations: 'locals/confirmations'
  }
  resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]

  resources :locals, only: [:show] do
    resources :articles, only: [:index]
    member do
      get :bookmarks, :talkrooms
    end
  end

  resources :prefectures, only: [:index, :show]

  get 'search', to: 'locals#search'

  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
     registrations: "users/registrations",
     confirmations: 'users/confirmations'
    }
  #get 'users/:id', to: 'users#show', as: 'user'
  resources :users, only: [:show] do
    member do
      get :bookmarks, :talkrooms
    end
  end
  resources :user_profiles, only: [:new, :create, :edit, :update]

  resources :bookmarks, only: [:create, :destroy]
  resources :messages, only: [:destroy]
  resources :talkrooms, only: [:index, :create, :destroy] do
      resources :messages, only: [:new, :create, :index]
  end
  resources :contacts, only: [:create]

  resources :scores, only: [:new, :create, :edit, :update]
  resources :profiles, only: [:new, :create, :edit, :update]
  get '/welcome', to: 'onboadings#welcome'
  get '/home', to: 'recommends#index'
  get '/timeline', to: 'users#timeline'
  get '/contact', to: 'contacts#new'
  get '/top', to: 'static_pages#home'
end
