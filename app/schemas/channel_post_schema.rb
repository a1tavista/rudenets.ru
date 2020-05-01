class ChannelPostSchema < Dry::Validation::Contract
  params do
    optional(:title).value(:string)
    required(:content_blocks).value(:array)
  end

  class Strict < Dry::Validation::Contract
    params do
      required(:title).value(:string)
      required(:content_blocks).value(:array)
    end
  end
end
