class CoverUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original, options|
    shaped = Shapezator.new(original, options[:shapes_number], options[:mode]).call
    optimized_shaped = Optimizer.new(shaped).call
    optimized = Optimizer.new(original).call

    {
      optimized: optimized,
      shaped: optimized_shaped,
    }
  end
end
