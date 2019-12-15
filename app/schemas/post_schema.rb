class PostSchema < Dry::Validation::Contract
  params do
    required(:title).value(:string)
    optional(:summary).maybe(:string)
    optional(:text).maybe(:string)
    optional(:render_settings).hash do
      optional(:cover).maybe(:hash)
    end
    optional(:featured).value(:bool)
  end

  class Strict < Dry::Validation::Contract
    params do
      required(:title).filled(:string)
      required(:summary).filled(:string)
      required(:text).filled(:string)
      optional(:render_settings).hash do
        optional(:cover).value(:hash)
      end
      required(:featured).value(:bool)
    end
  end
end
