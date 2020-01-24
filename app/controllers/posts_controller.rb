class PostsController < ApplicationController
  include SeoHelper
  include Concerns::EntriesConcern

  load_and_authorize_resource find_by: :slug, except: [:preview]

  def index
    @entries, @highlighted_post = fetch_entries_with_highlighted
    @entries = @entries.page(params[:page]).per(10)

    render "entries/index"
  end

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
