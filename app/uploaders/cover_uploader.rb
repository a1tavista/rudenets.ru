class CoverUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original, options|
    def prepare_shaped_for(original, options: {})
      return if options.compact.blank?

      shaped = Shapezator.new(original, options[:shapes_number], options[:mode]).call
      Optimizer.new(shaped).call
    end

    optimized = Optimizer.new(original).call

    {
      optimized: optimized,
      shaped: prepare_shaped_for(original, options: options),
    }.compact
  end
end
