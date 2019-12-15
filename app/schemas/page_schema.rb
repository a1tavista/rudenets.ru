class PageSchema < Dry::Validation::Contract
  params do
    required(:url).filled(:string)
    required(:title).filled(:string)
    required(:content).filled(:string)
  end

  class Strict < Dry::Validation::Contract
    params do
      required(:url).filled(:string)
      required(:title).filled(:string)
      required(:content).filled(:string)
    end
  end
end
