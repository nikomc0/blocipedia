Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users
  root 'welcome#index'
end
