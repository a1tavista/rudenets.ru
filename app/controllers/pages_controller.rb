class PagesController < ApplicationController
  load_resource find_by: :url

  def show; end
end
