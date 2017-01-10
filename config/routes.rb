require 'sidekiq/web'

Rails.application.routes.draw do

  resources :players
  resources :users
  resources :factions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
