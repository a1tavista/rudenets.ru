class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    render 'errors/404', status: :not_found
  end
end
