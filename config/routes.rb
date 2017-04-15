Rails.application.routes.draw do
  root "entries#index"
  resources :entries
  resources :posts
  resources :links
end
