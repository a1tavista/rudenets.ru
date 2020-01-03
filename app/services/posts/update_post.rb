module Posts
  class UpdatePost
    include Dry::Transaction

    map :initialize_records
    step :validate
    step :update_post
    step :prerender_post_content

    def initialize_records(input)
      {
        post: input[:post] || Post.find_by(input[:post_find_by]),
        attributes: input[:attributes]
      }
    end

    def validate(input)
      result = PostSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def update_post(input)
      input[:post].update!(input[:attributes])
      Success(input)
    end

    def prerender_post_content(input)
      Posts::Operations::PrerenderPostContent.new.call(input)
    end
  end
end
