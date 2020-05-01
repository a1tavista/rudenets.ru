class PostsController < ApplicationController
  include SeoHelper
  include Concerns::EntriesConcern

  authorize_resource except: [:preview, :feed]

  def show
    Posts::Operations::FindPostBySlug.new.call(slug: params[:id]) do |monad|
      monad.success do |post|
        @post = post
        set_meta_tags(post_tags(@post))
      end
      monad.failure { raise ActiveRecord::RecordNotFound }
    end
  end

  def feed
    @posts = Publication::Post.published.sorted_by_publishing_time.first(10)

    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  def preview
    @post = Publication::Post.find_by_preview_access_hash(params[:hash])
    set_meta_tags(post_tags(@post))
    render :show
  end

  private

  def scoped_entries(all_entries)
    all_entries.posts
  end
end
