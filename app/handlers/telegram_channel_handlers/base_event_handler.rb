module TelegramChannelHandlers
  class BaseEventHandler < BaseHandler
    attr_reader :bot
    delegate :url_helpers, to: 'Rails.application.routes'

    def perform(event_id)
      @bot = TelegramBot.new
      @event = event_store.read.event(event_id)

      send_notification
    end

    private

    def host
      return ENV.fetch('APPLICATION_HOST') if Rails.env.production?

      ENV.fetch('APPLICATION_HOST', 'localhost:3000')
    end
  end
end
