module Concerns::EntriesConcern
  extend ActiveSupport::Concern

  include Dry::Monads[:maybe]

  def index
    @entries, @highlighted_post = fetch_entries_with_highlighted
    @entries = @entries.page(params[:page]).per(10)

    render "entries/index"
  end

  private

  def fetch_entries
    Entry
        .includes(:taxonomy)
        .published
        .sorted_by_publishing_time
  end

  def scoped_entries(all_entries)
    all_entries
  end

  def remove_highlighted_from(all_entries, post)
    post&.featured? ? all_entries : all_entries.where.not(taxonomy: post)
  end

  def fetch_entries_with_highlighted
    all_entries = fetch_entries
    highlighted_post = Maybe(fetch_featured_from(all_entries)).value_or { highlight_new_post_from(all_entries) }.taxonomy

    [scoped_entries(remove_highlighted_from(all_entries, highlighted_post)), highlighted_post]
  end

  def fetch_featured_from(entries)
    entries.posts.joins("INNER JOIN posts ON entries.taxonomy_id = posts.id").where(posts: {featured: true}).first
  end

  def highlight_new_post_from(entries)
    entries.posts.first
  end
end