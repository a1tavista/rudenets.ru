class LinksController < ApplicationController
  def index
    @entries = Entry.includes(:taxonomy)
                 .published
                 .sorted_by_creation_time
                 .where('taxonomy_type = ?', Link)
    render 'entries/index'
  end
end
