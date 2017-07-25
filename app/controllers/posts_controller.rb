class PostsController < ApplicationController
  include SeoHelper
  load_and_authorize_resource find_by: :slug

  def index
    @entries = Entry.includes(:taxonomy)
               .published
               .sorted_by_creation_time
               .where('taxonomy_type = ?', Post)
    render 'entries/index'
  end

  def show
    set_meta_tags(post_tags(@post))
    @post
  end
end
