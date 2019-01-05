class LinksController < ApplicationController
  def index
    @links = Entry.includes(:taxonomy).
             published.
             sorted_by_publishing_time.
             where('taxonomy_type = ?', Link).
             page(params[:page]).per(10)
    render 'entries/index'
  end
end
