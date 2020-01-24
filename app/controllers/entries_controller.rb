class EntriesController < ApplicationController
  include Concerns::EntriesConcern

  load_and_authorize_resource

  def index
    @entries, @highlighted_post = fetch_entries_with_highlighted
    @entries = @entries.page(params[:page]).per(10)

    render "entries/index"
  end

  def scoped_entries(all_entries)
    all_entries.links
  end
end
