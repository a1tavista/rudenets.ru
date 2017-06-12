class Post < ApplicationRecord
  acts_as_taggable
  has_one :entry, as: :taxonomy
  has_many :images, as: :imageable
end
