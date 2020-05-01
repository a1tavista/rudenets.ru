module Handlers
  module TelegramChannelHandlers
    module NotifyChannel
      class UpdateMessageButtons < BaseEventHandler
        def send_notification
          publication = Publication.find(event.data[:publication_id])
          reaction = create_reaction_for(publication)

          return if reaction.invalid?

          publication.update(reactions_count: publication.reactions.count)
          bot.update_message_buttons(
            publication.publication_data.dig("telegram", "message_id"),
            buttons_data: build_buttons_for(publication)
          )
        end

        private

        def create_reaction_for(publication)
          Publication::Reaction.create(publication: publication, username: event.data[:username], data: event.data[:user])
        end
      end
    end
  end
end
