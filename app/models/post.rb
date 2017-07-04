class Post < ApplicationRecord
  acts_as_taggable
  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

  def self.refreshed_order
    order("updated_at DESC")
  end
end
