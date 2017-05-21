class AmazonUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    directory = "dev_uploads" if Rails.env.development?
    directory ||= "uploads"
    "#{directory}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
