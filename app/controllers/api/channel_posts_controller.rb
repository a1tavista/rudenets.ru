module Api
  class ChannelPostsController < BaseController
    load_resource except: [:create], class: Publication::ChannelPost

    def index
      @channel_posts = Publication::ChannelPost.sorted_by_publishing_time.order(updated_at: :desc)
      respond_with(@channel_posts)
    end

    def create
      ::ChannelPosts::Create.new.call(attributes: post_params.to_h) do |monad|
        monad.success { |result| @channel_post = result[:channel_post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def update
      ::ChannelPosts::Update.new.call(channel_post: @channel_post, attributes: post_params.to_h) do |monad|
        monad.success { |result| @channel_post = result[:channel_post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def destroy
      ::ChannelPosts::Remove.new.call(channel_post: @channel_post) do |monad|
        monad.success { |result| @channel_post = result[:channel_post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    private

    def post_params
      params.require(:channel_post).permit!
    end
  end
end
