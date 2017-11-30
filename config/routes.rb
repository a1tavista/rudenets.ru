Rails.application.routes.draw do
  root "entries#index"

  get '/cc' => 'clearance/sessions#new', as: :cc
  get '/bo(/*kek)' => 'backoffice#index'

  namespace :api do
    resources :links, only: [:create] do
      collection do
        get :parse
      end
    end
    resources :posts do
      get :published, on: :collection
      get :private, on: :collection
      put :publish, on: :member
      put :unpublish, on: :member
    end
    resources :labels, only: [:index]
  end

  resources :entries
  resources :posts
  resources :links
end
