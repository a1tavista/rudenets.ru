class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  include CarrierWave::DelayedVersions::ModelMethods
  mount_uploader :file, AmazonUploader

  after_save :process_images_async

  private

  def process_images_async
    ProcessImagesJob.perform_later('Link', id)
  end
end
