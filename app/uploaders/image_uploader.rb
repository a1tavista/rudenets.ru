class ImageUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original|
    {
      shaped: Shapezator.new(original, 200).call
    }
  end
end
