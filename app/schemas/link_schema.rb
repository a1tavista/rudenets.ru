class LinkSchema < Dry::Validation::Contract
  params do
    required(:url).filled(:string)
    required(:site_name).filled(:string)
    required(:title).filled(:string)
    optional(:summary).value(:string)
    optional(:description).value(:string)
    optional(:image_url).maybe(:string)
  end

  class Strict < LinkSchema; end
end
