class EntriesController < ApplicationController

  load_and_authorize_resource

  def index
    @entries = Entry.includes(:taxonomy).sorted_by_creation_time
  end

  def show; end
  def archieve; end

  def publish; end
  def unpublish; end
end
