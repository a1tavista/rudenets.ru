class Link < ApplicationRecord
  has_one :entry, as: :taxonomy
  validates_uniqueness_of :url

  include CarrierWave::DelayedVersions::ModelMethods
  mount_uploader :image, AmazonUploader

  before_save :set_empty_summary_to_nil
  after_save :process_images_async

  private

  def process_images_async
    ProcessImagesJob.perform_later('Link', id)
  end

  def set_empty_summary_to_nil
    self.summary = nil if summary.empty?
  end
end
