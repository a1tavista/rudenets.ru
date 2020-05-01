module ChannelPosts
  class Update
    include Dry::Transaction

    map :initialize_records
    step :validate
    step :update_post
    step :prerender_post_content

    def initialize_records(input)
      {
        channel_post: input[:channel_post] || Publication::ChannelPost.find_by(input[:channel_post_find_by]),
        attributes: input[:attributes],
      }
    end

    def validate(input)
      result = ChannelPostSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def update_post(input)
      input[:channel_post].update!(input[:attributes])
      Success(input)
    end

    def prerender_post_content(input)
      ChannelPosts::Operations::PrerenderPostContent.new.call(input)
    end
  end
end
