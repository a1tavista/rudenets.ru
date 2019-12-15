Rails.application.routes.draw do
  namespace :admin do
    resource :session, controller: "sessions", only: [:create, :new]

    constraints Clearance::Constraints::SignedIn.new do
      root to: "base#index", as: :admin_root
    end

    get "/sign_in" => "sessions#new", :as => "sign_in"
    delete "/sign_out" => "sessions#destroy", :as => "sign_out"
  end
end
