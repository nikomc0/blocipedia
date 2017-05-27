Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:downgrade] do
    member do
      post :downgrade
    end
  end

  devise_for :users
  root 'welcome#index'
end
