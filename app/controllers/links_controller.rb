class LinksController < ApplicationController
  include Concerns::EntriesConcern

  def index
    @entries, @highlighted_post = fetch_entries_with_highlighted
    @entries = @entries.page(params[:page]).per(10)

    render "entries/index"
  end

  def go
    return redirect_to root_path if params[:url].nil?

    link = Link.find_by(url: params[:url])
    link.increment!(:follows_count)
    redirect_to link.url
  end
end
