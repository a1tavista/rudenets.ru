class Entry < ApplicationRecord
  belongs_to :taxonomy, polymorphic: true

  def self.published
    where(:published => true)
  end

  def self.sorted_by_publishing_time
    order("published_at DESC")
  end

  def self.sorted_by_creation_time
    order("created_at DESC")
  end
end
