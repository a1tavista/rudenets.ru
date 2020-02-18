module TelegramChannelHandlers
  module NotifyChannel
    class NewLink < BaseEventHandler
      def send_notification
        bot.notify(
          content_for(Link.find(event.data[:link_id]))
        )
      end

      private

      def content_for(link)
        url = url_helpers.go_links_url(url: link.url, host: host)

        [
          "\u{2615} Рекомендация: <b><a href=\"#{url}\">#{link.title}</a></b>",
          ("\n<i>#{link.description}</i>" unless link.description.blank?),
          ("\n--------------\n\n#{link.summary}" unless link.summary.blank?)
        ].compact.join("\n")
      end
    end
  end
end
