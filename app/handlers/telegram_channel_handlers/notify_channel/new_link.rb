module TelegramChannelHandlers
  module NotifyChannel
    class NewLink < BaseEventHandler
      def send_notification
        link = Publication::Link.find(event.data[:publication_id])

        bot
          .send_message(content_for(link), buttons_data: build_buttons_for(link))
          .fmap { |result| set_message_id_for(link, message_id: result[:message_id]) }
      end

      private

      def content_for(link)
        url = url_helpers.go_links_url(url: link.source_url, host: host)

        [
          "\u{2615} Рекомендация: <b><a href=\"#{url}\">#{link.title}</a></b>",
          ("\n<i>#{link.abstract}</i>" unless link.abstract.blank?),
          ("\n--------------\n\n#{link.prerendered_content}" unless link.prerendered_content.blank?),
        ].compact.join("\n")
      end
    end
  end
end
