class Link < ApplicationRecord
  has_one :entry, as: :taxonomy

  include ImageUploader::Attachment(:image)

  accepts_nested_attributes_for :entry, update_only: true

  def host
    URI.parse(url).host
  end
end
