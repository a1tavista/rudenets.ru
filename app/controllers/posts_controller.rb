class PostsController < ApplicationController
  include SeoHelper
  include Concerns::EntriesConcern

  load_and_authorize_resource find_by: :slug, except: [:preview, :feed]

  def show
    set_meta_tags(post_tags(@post))
  end

  def feed
    @posts = Post.published.joins(:entry).order("entries.published_at DESC").first(10)

    respond_to do |format|
      format.rss { render layout: false }
    end
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
