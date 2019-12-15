class EntriesController < ApplicationController
  load_and_authorize_resource

  def index
    @entries = Entry
      .includes(:taxonomy)
      .published
      .sorted_by_publishing_time
      .first(10)

    @featured_post = fetch_featured
  end

  private

  def fetch_featured
    posts = Post.joins(:entry).order("entries.published_at DESC").where(entries: {published: true})
    posts.where(featured: true).first || posts.first
  end
end
