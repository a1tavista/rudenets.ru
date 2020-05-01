class Post < ApplicationRecord
  include ImageUploader::Attachment(:preview_image)
  include CoverUploader::Attachment(:cover_image)

  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable
  has_many :aliases, class_name: "Post::Alias", dependent: :destroy

  scope :published, -> { joins(:entry).where(entries: {published: true}).where("entries.published_at <= ?", Time.current) }
  scope :unpublished, -> { joins(:entry).where(entries: {published: false}) }

  accepts_nested_attributes_for :entry, update_only: true
end
