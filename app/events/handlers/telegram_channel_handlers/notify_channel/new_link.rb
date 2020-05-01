module Handlers
  module TelegramChannelHandlers
    module NotifyChannel
      class NewLink < BaseEventHandler
        def send_notification
          publication = Publication::Link.find(event.data[:publication_id])

          bot
            .send_message(content_for(publication), buttons_data: build_buttons_for(publication))
            .fmap { |result| set_message_id_for(publication, message_id: result[:message_id]) }
        end

        private

        def content_for(link)
          url = url_helpers.go_links_url(url: link.source_url, host: host)

          [
            "\u{2615} Рекомендация: <b><a href=\"#{url}\">#{link.title}</a></b>",
            ("<i>#{link.abstract}</i>" unless link.abstract.blank?),
            render_comment_for(link),
          ].compact.join("\n\n")
        end

        def render_comment_for(link)
          return if link.notion.blank?

          html_content = telegram_renderer.render(link.notion)

          "-------------------\n\n#{html_content}"
        end
      end
    end
  end
end
