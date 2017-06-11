Rails.application.routes.draw do
  root "entries#index"

  get '/cc' => 'clearance/sessions#new', as: :cc
  get '/bo' => 'backoffice#index'

  namespace :api do
    resources :links, only: [:create] do
      collection do
        get :parse
      end
    end
    resources :posts, only: [:create]
  end

  resources :entries
  resources :posts
  resources :links
end
