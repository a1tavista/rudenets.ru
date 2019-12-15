class Post < ApplicationRecord
  include FriendlyId
  include ImageUploader::Attachment(:preview_image)
  include CoverUploader::Attachment(:cover_image)

  friendly_id :slug

  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

  scope :published, -> { joins(:entry).where(entries: {published: true}).where('entries.published_at >= ?', Time.current) }
  scope :unpublished, -> { joins(:entry).where(entries: {published: false}) }

  accepts_nested_attributes_for :entry, update_only: true
end
