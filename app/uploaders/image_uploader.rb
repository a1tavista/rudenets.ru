require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original|
    optimized = Optimizer.new(original).call
    magick = ::ImageProcessing::MiniMagick.source(optimized)

    {
      optimized: optimized,
      large: magick.resize_to_fit!(1000, 1000),
      medium: magick.resize_to_fit!(600, 600),
      small: magick.resize_to_fit!(300, 300),
    }
  end
end
