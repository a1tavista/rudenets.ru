class PostCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::DelayedVersions

  storage :fog

  version :shaped, if: :raster? do
    # process :shaperize_image

    # def full_filename(for_file)
    #   "#{super.chomp(File.extname(super))}.png"
    # end
  end

  def number_of_shapes
    model&.render_settings&.dig('cover', 'number_of_shapes') || 300
  end

  def raster?(new_file)
    ext = new_file.extension.to_s.downcase
    ext.include?('jpg') || ext.include?('jpeg') || ext.include?('png')
  end

  def store_dir
    directory ||= 'uploads'
    "#{directory}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    'cover.png'
  end
end
