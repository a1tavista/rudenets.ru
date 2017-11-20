class EntriesController < ApplicationController
  load_and_authorize_resource

  def index
    @entries = Entry
                 .includes(:taxonomy)
                 .published
                 .sorted_by_publishing_time
                 .page(params[:page])
  end

  def show; end
  def archieve; end

  def publish; end
  def unpublish; end
end
