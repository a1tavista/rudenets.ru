module Subscriptions
  class TelegramChannelHandlers
    def self.subscribe(event_store)
      event_store.subscribe(
        ::TelegramChannelHandlers::NotifyChannel,
        to: [Events::LinkPublished, Events::PostPublished]
      )
    end
  end
end
