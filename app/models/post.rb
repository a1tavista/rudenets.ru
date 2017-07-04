class Post < ApplicationRecord
  acts_as_taggable
  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

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
