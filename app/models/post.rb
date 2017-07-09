class Post < ApplicationRecord
  acts_as_taggable
  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

  include FriendlyId
  friendly_id :canonical_url, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def canonical_url
    "#{I18n.l(created_at, format: :slug)} #{Russian.translit(title)}"
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
end
