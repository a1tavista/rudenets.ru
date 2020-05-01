module Handlers
  module TelegramChannelHandlers
    module NotifyChannel
      class NewPost < BaseEventHandler
        def send_notification
          publication = Publication::Post.find(event.data[:publication_id])

          bot
            .send_message(content_for(publication), buttons_data: build_buttons_for(publication))
            .fmap { |result| set_message_id_for(publication, message_id: result[:message_id]) }
        end

        private

        def content_for(post)
          url = url_helpers.post_url(post.slug, host: host)

          [
            "\u{2B50} Новая публикация в блоге \u{2B50}",
            "<b><a href=\"#{url}\">#{post.title}</a></b>",
            render_abstract_of(post),
          ].compact.join("\n\n")
        end

        def render_abstract_of(post)
          return if post.abstract.blank?

          telegram_renderer.render(post.abstract)
        end
      end
    end
  end
end
