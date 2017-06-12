class Api::BaseController < ActionController::Base
  include Clearance::Controller
  respond_to :json
  before_action :require_login
  before_action :verify_requested_format!
end
