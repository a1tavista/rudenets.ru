require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original|
    optimized = Optimizer.new(original).call
    medium = ::ImageProcessing::MiniMagick.source(optimized).resize_to_fit(600, 600).call
    small = ::ImageProcessing::MiniMagick.source(optimized).resize_to_fit(300, 300).call

    {
      optimized: optimized,
      medium: medium,
      small: small,
    }
  end
end
