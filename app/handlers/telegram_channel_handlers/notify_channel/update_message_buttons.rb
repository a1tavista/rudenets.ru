module TelegramChannelHandlers
  module NotifyChannel
    class UpdateMessageButtons < BaseEventHandler
      def send_notification
        publication = Publication.find(event.data[:publication_id])
        bot.update_message_buttons(
          publication.publication_data.dig("telegram", "message_id"),
          buttons_data: build_buttons_for(publication)
        )
      end
    end
  end
end
