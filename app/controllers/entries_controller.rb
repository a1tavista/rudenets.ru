class EntriesController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Entry
                 .includes(:taxonomy)
                 .where('taxonomy_type = ?', Post)
                 .published
                 .sorted_by_publishing_time
                 .first(3)

    @links = Entry
               .includes(:taxonomy)
               .where('taxonomy_type = ?', Link)
               .published
               .sorted_by_publishing_time
               .first(3)
    @featured_post = Post.where(featured_post: true, entries: { published: true })
  end

  def show; end
  def archieve; end

  def publish; end
  def unpublish; end
end
