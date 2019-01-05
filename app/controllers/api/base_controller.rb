module Api
  class BaseController < ActionController::API
    include Clearance::Controller
    include CanCan::ControllerAdditions
    include ActionView::Rendering
    include AbstractController::Translation

    before_action :require_login
    before_action :verify_requested_format!

    respond_to :json
  end
end
