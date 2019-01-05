class Link < ApplicationRecord
  has_one :entry, as: :taxonomy
  validates_uniqueness_of :url
  mount_uploader :image, AmazonUploader

  before_save :set_empty_summary_to_nil

  private

  def set_empty_summary_to_nil
    self.summary = nil if summary.empty?
  end
end
