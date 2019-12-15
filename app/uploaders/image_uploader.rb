class ImageUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original|
    optimized = Optimizer.new(original).call

    {
      large: prepare_thumbnail(optimized, dimensions: [960, 960]),
      medium: prepare_thumbnail(optimized, dimensions: [1024, 1024]),
      small: prepare_thumbnail(optimized, dimensions: [2048, 2048]),
    }
  end

  private

  def prepare_thumbnail(image, dimensions:)
    magick = ImageProcessing::MiniMagick.source(image)
    magick.resize_to_fit!(*dimensions)
  end
end
