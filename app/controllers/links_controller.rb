class LinksController < ApplicationController
  include Concerns::EntriesConcern

  def go
    return redirect_to root_path if params[:url].nil?

    link = Link.find_by(url: params[:url])
    link.increment!(:follows_count)
    redirect_to link.url
  end

  private

  def scoped_entries(all_entries)
    all_entries.links
  end
end
