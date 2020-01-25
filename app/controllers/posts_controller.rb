class PostsController < ApplicationController
  include SeoHelper
  include Concerns::EntriesConcern

  load_and_authorize_resource find_by: :slug, except: [:preview]

  def show
    set_meta_tags(post_tags(@post))
  end

  def preview
    @post = Post.find_by_preview_hash(params[:hash])
    set_meta_tags(post_tags(@post))
    render :show
  end

  private

  def scoped_entries(all_entries)
    all_entries.posts
  end
end
