class BackofficeController < ApplicationController
  layout "backoffice"
  before_action :require_login, only: [:backoffice]

  def backoffice
    render layout: :backoffice
  end
end
