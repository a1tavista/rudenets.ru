module TelegramChannelHandlers
  module NotifyChannel
    class NewPost < BaseEventHandler
      def send_notification
        bot.notify(
          content_for(Post.find(event.data[:post_id]))
        )
      end

      private

      def content_for(post)
        url = url_helpers.post_url(post, host: host)

        [
          "\u{2B50} Новая публикация в блоге \u{2B50}",
          "\n<b><a href=\"#{url}\">#{post.title}</a></b>",
          ("\n#{post.summary}" unless post.summary.blank?)
        ].compact.join("\n")
      end
    end
  end
end
