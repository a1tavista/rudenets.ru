class PostsController < ApplicationController
  include SeoHelper
  load_and_authorize_resource find_by: :slug

  def index
    @posts = Entry.includes(:taxonomy)
                    .published
                    .sorted_by_publishing_time
                    .where('taxonomy_type = ?', Post)
                    .page(params[:page]).per(10)
    render 'entries/index'
  end

  def show
    set_meta_tags(post_tags(@post))
  end
end
