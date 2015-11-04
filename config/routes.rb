Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :porfolios, only: [:show, :update, :new, :create]
end
