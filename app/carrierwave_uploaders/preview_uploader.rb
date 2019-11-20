class PreviewUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    directory ||= 'uploads'
    "#{directory}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    'preview.png'
  end
end
