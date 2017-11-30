class Post < ApplicationRecord
  include FriendlyId

  acts_as_taggable
  friendly_id :slug

  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

  after_touch :update_canonical_url
  before_save :update_canonical_url

  def update_canonical_url
    return if entry&.published_at.nil?
    slug_date = I18n.l(entry.published_at, format: :slug)
    slug_title = Russian.translit(title).parameterize.downcase
    update_columns(slug: "#{slug_date}-#{slug_title}")
  end

  def self.published
    includes(:entry).where(entries: { published: true })
  end

  def self.unpublished
    includes(:entry).where(entries: { published: false })
  end

  def self.refreshed_order
    order("posts.updated_at DESC")
  end

  def is_published
    entry.published?
  end
end
