class Post < ApplicationRecord
  has_one :entry, as: :taxonomy
  has_many :images, as: :imageable
end
