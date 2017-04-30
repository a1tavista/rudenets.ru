Rails.application.routes.draw do
  root "entries#index"

  get '/cc' => 'clearance/sessions#new', as: :cc

  namespace :api do
    resources :links, only: [:create] do
      collection do
        get :parse
      end
    end
  end

  resources :entries
  resources :posts
  resources :links
end
