Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'portfolios#new', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  root 'welcome#index'

  resources :portfolios, only: [:show, :update, :new, :create]
end
