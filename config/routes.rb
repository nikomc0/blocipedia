Rails.application.routes.draw do
  resources :charges, only: [:new, :create] do
    member do
      post :downgrade
    end
  end

  resources :wikis

  devise_for :users
  root 'welcome#index'
end
