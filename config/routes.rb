Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :portfolios, only: [:show, :update, :new, :create]
end
