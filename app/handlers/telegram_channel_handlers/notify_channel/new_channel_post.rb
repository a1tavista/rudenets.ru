module TelegramChannelHandlers
  module NotifyChannel
    class NewChannelPost < BaseEventHandler
      def send_notification
        post = Publication::Post.find(event.data[:publication_id])

        bot
          .send_message(content_for(post), buttons_data: build_buttons_for(post))
          .fmap { |result| set_message_id_for(post, message_id: result[:message_id]) }
      end

      private

      def content_for(post)
        post.prerendered_content
      end
    end
  end
end
