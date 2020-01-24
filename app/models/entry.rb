class Entry < ApplicationRecord
  belongs_to :taxonomy, polymorphic: true, dependent: :destroy, touch: true

  scope :posts, -> { where(entries: {taxonomy_type: 'Post'}) }
  scope :links, -> { where(entries: {taxonomy_type: 'Link'}) }

  scope :published, -> { where('"entries"."published"', true) }
  scope :sorted_by_publishing_time, -> { order('"entries"."published_at" DESC') }
  scope :sorted_by_creation_time, -> { order('"entries"."created_at" DESC') }
end
