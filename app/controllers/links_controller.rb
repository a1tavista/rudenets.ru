class LinksController < ApplicationController
  def index
    @entries = Entry.includes(:taxonomy)
                 .published
                 .sorted_by_publishing_time
                 .where('taxonomy_type = ?', Link)
                 .page(params[:page])
    render 'entries/index'
  end
end
