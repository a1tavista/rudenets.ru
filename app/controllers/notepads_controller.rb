class NotepadsController < ApplicationController
  load_resource find_by: :share_url
  layout 'single'
  def show; end
end
