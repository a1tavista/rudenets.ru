class Entry < ApplicationRecord
  belongs_to :taxonomy, polymorphic: true, dependent: :destroy, touch: true

  def self.published
    where('"entries"."published"', true)
  end

  def self.sorted_by_publishing_time
    order('"entries"."published_at" DESC')
  end

  def self.sorted_by_creation_time
    order('"entries"."created_at" DESC')
  end

  def publish!
    update(published: true, published_at: Time.current)
  end

  def unpublish!
    update(published: false, published_at: nil)
  end
end
