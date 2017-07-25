class BackofficeController < ApplicationController
  layout "backoffice"
  before_action :require_login

  def backoffice
    render layout: :backoffice
  end
end
