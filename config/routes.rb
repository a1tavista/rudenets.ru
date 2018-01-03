Rails.application.routes.draw do
  root "entries#index"

  get '/cc' => 'clearance/sessions#new', as: :cc
  get '/bo(/*kek)' => 'backoffice#index'

  namespace :api do
    resources :links do
      get :parse, on: :collection
      put :publish, on: :member
      put :unpublish, on: :member
    end
    resources :posts do
      get :published, on: :collection
      get :private, on: :collection
      put :publish, on: :member
      put :unpublish, on: :member
    end
    resources :labels, only: [:index]
    resources :pages, only: %i(index show update)
  end

  resources :entries
  resources :posts
  resources :links

  get '/(:id)', to: 'pages#show', as: :page
end
