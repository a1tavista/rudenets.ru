module Posts
  class Create
    include Dry::Transaction

    step :validate
    step :create_post

    def validate(input)
      result = PostSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def create_post(input)
      publication = Publication::Post.create!(
        input[:attributes].merge(preview_access_hash: SecureRandom.uuid, publication_data: {})
      )
      Success(input.merge(publication: publication))
    end
  end
end
