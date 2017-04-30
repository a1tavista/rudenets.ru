class Entry < ApplicationRecord
  belongs_to :taxonomy, polymorphic: true

  def self.published
    where(:published => true)
  end

  def self.sorted
    order("published_at DESC")
  end
end
