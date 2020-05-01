module ChannelPosts
  class Create
    include Dry::Transaction

    step :validate
    step :create_post

    def validate(input)
      result = ChannelPostSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def create_post(input)
      channel_post = Publication::ChannelPost.create!(
        input[:attributes].merge(preview_access_hash: SecureRandom.uuid, publication_data: {})
      )
      Success(input.merge(channel_post: channel_post))
    end
  end
end
