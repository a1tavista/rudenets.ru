module Handlers
  module TelegramChannelHandlers
    module NotifyChannel
      class NewChannelPost < BaseEventHandler
        def send_notification
          publication = Publication::ChannelPost.find(event.data[:publication_id])

          ids = prepare_messages_by(publication)
            .map { |content_for_post| bot.send_message(content_for_post, buttons_data: [], parse_mode: "HTML") }
            .map { |result| result.value_or({})[:message_id] }

          return ids.compact.each { |id| bot.delete_message(id) } if ids.blank? || ids.any?(&:blank?)

          publication.set_message_ids!(ids)
          bot.update_message_buttons(
            publication.message_id,
            buttons_data: build_buttons_for(publication)
          )
        end

        private

        def prepare_messages_by(post)
          post.content_blocks.map { |b| telegram_renderer.render(b["value"]) }
        end
      end
    end
  end
end
