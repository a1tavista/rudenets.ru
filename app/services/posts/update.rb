module Posts
  class Update
    include Dry::Transaction

    map :initialize_records
    step :validate
    step :update_post
    map :update_slug
    step :prerender_post_content

    def initialize_records(input)
      {
        publication: input[:publication] || Publication::Post.find_by(input[:publication_find_by]),
        attributes: input[:attributes],
      }
    end

    def validate(input)
      result = PostSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def update_post(input)
      input[:publication].update!(input[:attributes])
      Success(input)
    end

    def update_slug(input)
      Posts::Operations::UpdateSlug.new.call(input.merge(publishing_time: input[:publication].published_at))
      input
    end

    def prerender_post_content(input)
      Posts::Operations::CacheContent.new.call(input)
    end
  end
end
