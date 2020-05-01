module ChannelPosts
  class Removes
    include Dry::Transaction

    map :initialize_records
    step :remove_post

    def initialize_records(input)
      {
        channel_post: input[:channel_post] || Publication::ChannelPost.find_by(input[:channel_post_find_by]),
        attributes: input[:attributes],
      }
    end

    def remove_post(input)
      input[:channel_post].destroy!
      Success(input)
    end
  end
end
