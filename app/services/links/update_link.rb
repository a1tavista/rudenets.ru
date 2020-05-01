module Links
  class UpdateLink
    include Dry::Transaction

    map :initialize_records
    step :validate
    step :update_link

    def initialize_records(input)
      {
        link: input[:post] || Publication::Link.find_by(input[:link_find_by]),
        attributes: input[:attributes],
      }
    end

    def validate(input)
      result = LinkSchema.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def update_link(input)
      input[:link].update!(input[:attributes])
      Success(input)
    end
  end
end
