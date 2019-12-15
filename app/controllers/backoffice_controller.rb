class BackofficeController < ApplicationController
  layout "backoffice"
  before_action :require_login

  def backoffice
    render layout: :backoffice
  end

  def url_after_denied_access_when_signed_out
    cc_url
  end
end
