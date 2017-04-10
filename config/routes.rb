Rails.application.routes.draw do
  root "high_voltage/pages#show", id: "index"

  resources :posts
  resources :links
end
#
# [:admin].each do |route_file|
#   require_dependency "#{Rails.root}/config/routes/#{route_file}"
# end
