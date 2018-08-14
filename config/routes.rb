Rails.application.routes.draw do
  root 'entries#index'

  get '/cc/sign_in' => 'clearance/sessions#new', as: :cc
  get '/cc(/*kek)' => 'backoffice#index'

  get :typography, to: 'pages#typography'

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
    resources :notepads, only: %i(index show create update) do
      get :current, on: :collection
      get :tree, on: :collection
    end
  end

  resources :entries
  resources :posts do
    get :preview, on: :member
  end
  resources :links
  resources :notepads, path: 'n', only: [:show]

  get '/(:id)', to: 'pages#show', as: :page
end
