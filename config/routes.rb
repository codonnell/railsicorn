require 'sidekiq/web'

Rails.application.routes.draw do

  post 'users', to: 'users#create'
  post 'players', to: 'players#show'

  # resources :players
  # resources :users
  # resources :factions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
