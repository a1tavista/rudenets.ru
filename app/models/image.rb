class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  include ImageUploader::Attachment(:image)
end
