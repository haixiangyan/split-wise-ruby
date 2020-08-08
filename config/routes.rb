Rails.application.routes.draw do
  get '/hello', to: 'first#hello'
  get '/hi', to: 'first#hi'
  get '/me', to: 'users#me'

  resources :users
  resources :sessions, only: [:create, :destroy]
end
