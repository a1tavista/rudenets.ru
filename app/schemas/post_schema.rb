class PostSchema < Dry::Validation::Contract
  params do
    required(:title).value(:string)
    optional(:summary).maybe(:string)
    optional(:text).maybe(:string)
    optional(:render_settings).hash do
      optional(:cover).maybe(:hash)
    end
    optional(:featured).value(:bool)
    optional(:content_blocks).value(:array)
  end

  class Strict < Dry::Validation::Contract
    params do
      required(:title).filled(:string)
      required(:summary).filled(:string)
      required(:text).filled(:string)
      optional(:render_settings).hash do
        optional(:cover).value(:hash)
      end
      required(:content_blocks).value(:array)
      required(:featured).value(:bool)
    end
  end
end
