class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  SHRINE_CARRIERWAVE_MAPPING = {
    file: :image
  }.freeze

  mount_uploader :file, AmazonUploader
  include CarrierwaveShrineSynchronization
end
