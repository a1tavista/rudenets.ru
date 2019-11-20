class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  mount_uploader :file, AmazonUploader
  include CarrierwaveShrineSynchronization
end
