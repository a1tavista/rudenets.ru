class AmazonUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::ImageOptimizer

  storage :fog

  def raster?(new_file)
    ext = new_file.extension.to_s.downcase
    ext.include?('jpg') || ext.include?('jpeg') || ext.include?('png')
  end

  version :small, if: :raster? do
    process resize_to_fit: [960, 960]
    process optimize: [{ quality: 75 }]
  end

  version :medium, if: :raster? do
    process resize_to_fit: [1024, 1024]
    process optimize: [{ quality: 50 }]
  end

  version :large, if: :raster? do
    process resize_to_fit: [2048, 2048]
    process optimize: [{ quality: 50 }]
  end

  def store_dir
    directory = "dev_uploads" if Rails.env.development?
    directory ||= "uploads"
    "#{directory}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
