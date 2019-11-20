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
    resources :images
    resources :posts do
      get :published, on: :collection
      get :private, on: :collection
      put :publish, on: :member
      put :unpublish, on: :member
    end
    resources :pages, only: [:index, :show, :update]
  end

  resources :entries
  resources :posts do
    get :preview, on: :member
  end
  resources :links do
    get :go, on: :collection
  end

  get '/(:id)', to: 'pages#show', as: :page
end
