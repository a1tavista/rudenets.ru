module Api
  module ChannelPosts
    class PublicationsController < BaseController
      load_resource :channel_post, class: Publication::ChannelPost

      def create
        ::Publications::Publish.new.call(publication_params) do |monad|
          monad.success { |result| @channel_post = result[:publication] }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      private

      def publication_params
        {publication: @channel_post}
      end
    end
  end
end
