class LinksController < ApplicationController
  def index
    @entries = Entry.includes(:taxonomy).
             published.
             sorted_by_publishing_time.
             where('taxonomy_type = ?', Link).
             page(params[:page]).per(10)
    render 'entries/index'
  end

  def go
    return redirect_to root_path if params[:url].nil?
    link = Link.find_by(url: params[:url])
    link.increment!(:follows_count)
    redirect_to link.url
  end
end
