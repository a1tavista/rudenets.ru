class LinkSchema < Dry::Validation::Contract
  params do
    required(:source_url).filled(:string)
    required(:source_name).filled(:string)
    required(:title).filled(:string)
    optional(:content_blocks).value(:array)
    optional(:abstract).value(:string)
    optional(:cover_image_url).maybe(:string)
  end

  class Strict < LinkSchema; end
end
