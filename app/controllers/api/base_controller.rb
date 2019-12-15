module Api
  class BaseController < ActionController::API
    helper ApplicationHelper

    include Clearance::Controller
    include CanCan::ControllerAdditions
    include ActionView::Rendering
    include AbstractController::Translation


    before_action :require_login
    before_action :verify_requested_format!

    respond_to :json

    def respond_with_error(error, status:)
      render json: error.to_json, status: status
    end
  end
end
