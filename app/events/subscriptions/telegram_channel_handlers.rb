module Subscriptions
  class TelegramChannelHandlers
    def self.subscribe(event_store)
      event_store.subscribe(
        ::TelegramChannelHandlers::EventDispatcher,
        to: [Events::LinkPublished, Events::PostPublished, Events::ReactionReceived]
      )
    end
  end
end
