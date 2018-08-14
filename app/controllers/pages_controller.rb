class PagesController < ApplicationController
  load_resource find_by: :url, only: [:show]

  def show; end

  def typography; end
end
