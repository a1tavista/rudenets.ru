Rails.application.routes.draw do
  root "entries#index"

  get "/cc/sign_in" => "clearance/sessions#new", :as => :cc
  get "/cc(/*any)" => "backoffice#index"

  get :typography, to: "pages#typography"

  namespace :api do
    resources :links do
      resource :publication, module: :links
    end
    resources :images
    resources :posts do
      resource :publication, module: :posts
      resource :cover_image, only: [:create] do
        post :shaped
      end
    end
    resources :pages, only: [:index, :show, :update]
  end

  resources :entries
  resources :posts do
    get "preview/:hash", action: :preview, on: :collection, as: :preview
  end
  resources :links do
    get :go, on: :collection
  end

  get "/(:id)", to: "pages#show", as: :page
end
