Rails.application.routes.draw do
  get 'recommends/index'
  root 'static_pages#home'
  get 'static_pages/home_local'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
end
