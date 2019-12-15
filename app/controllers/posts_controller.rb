class PostsController < ApplicationController
  include SeoHelper
  load_and_authorize_resource find_by: :slug, except: [:preview]

  def index
    @entries = Entry.includes(:taxonomy)
      .published
      .sorted_by_publishing_time
      .where("taxonomy_type = ?", Post)
      .page(params[:page]).per(10)
    @featured_post = fetch_featured
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

  def fetch_featured
    posts = Post.joins(:entry).order("entries.published_at DESC").where(entries: {published: true})
    posts.where(featured: true).first || posts.first
  end
end
