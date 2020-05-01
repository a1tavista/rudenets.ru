module TelegramChannelHandlers
  module NotifyChannel
    class NewPost < BaseEventHandler
      def send_notification
        post = Publication::Post.find(event.data[:publication_id])

        bot
          .send_message(content_for(post), buttons_data: build_buttons_for(post))
          .fmap { |result| set_message_id_for(post, message_id: result[:message_id]) }
      end

      private

      def content_for(post)
        url = url_helpers.post_url(post.slug, host: host)

        [
          "\u{2B50} Новая публикация в блоге \u{2B50}",
          "\n<b><a href=\"#{url}\">#{post.title}</a></b>",
          ("\n#{post.abstract}" unless post.abstract.blank?),
        ].compact.join("\n")
      end
    end
  end
end
