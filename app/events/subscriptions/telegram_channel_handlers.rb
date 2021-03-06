module Subscriptions
  class TelegramChannelHandlers
    def self.subscribe(event_store)
      event_store.subscribe(
        ::Handlers::TelegramChannelHandlers::EventDispatcher,
        to: [
          Events::LinkPublished,
          Events::PostPublished,
          Events::ChannelPostPublished,
          Events::ReactionReceived,
        ]
      )
    end
  end
end
