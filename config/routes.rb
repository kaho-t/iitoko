Rails.application.routes.draw do

  get 'bookmarks/create'
  get 'bookmarks/destroy'
  resources :tags, only: [:new, :create, :edit, :update]
  
  devise_for :locals, controllers: {
    sessions: 'locals/sessions',
    passwords: 'locals/passwords',
    registrations: 'locals/registrations',
    confirmations: 'locals/confirmations'
  }
  resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :locals, only: [:show, :index] do
    resources :articles, only: [:index]
    member do
      get :bookmarks
    end
  end

  get 'search', to: 'locals#search'

  devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks',
     registrations: "users/registrations",
     confirmations: 'users/confirmations'
    }
  #get 'users/:id', to: 'users#show', as: 'user'
  resources :users, only: [:show] do
    member do
      get :bookmarks
    end
  end

  resources :bookmarks, only: [:create, :destroy]

  resources :scores, only: [:new, :create, :edit, :update]
  resources :profiles, only: [:new, :create, :edit, :update]
  get '/welcome', to: 'onboadings#welcome'
  get '/top', to: 'recommends#index'
  root 'static_pages#home'
  get 'static_pages/home_local'
end
