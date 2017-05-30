Rails.application.routes.draw do
  resources :charges, only: [:new, :create] do
    member do
      post :downgrade
    end
  end

  resources :wikis

  resource :users, only: [:show]

  devise_for :users
  root 'welcome#index'
end
