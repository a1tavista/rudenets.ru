module Handlers
  module TelegramChannelHandlers
    class BaseEventHandler < BaseHandler
      attr_reader :bot
      delegate :url_helpers, to: "Rails.application.routes"

      RENDERER_OPTIONS = {
        autolink: true,
        tables: false,
        footnotes: false,
        no_intra_emphasis: true,
        underline: true,
      }.freeze

      def perform(event_id)
        @bot = TelegramBot.new
        @event = event_store.read.event(event_id)

        send_notification
      end

      private

      def telegram_renderer
        @telegram_renderer ||= Redcarpet::Markdown.new(RenderForTelegram, self.class::RENDERER_OPTIONS)
      end

      def set_message_id_for(publication, message_id:)
        publication.update(publication_data: publication.publication_data.merge(telegram: {message_id: message_id}))
      end

      def build_buttons_for(publication)
        [
          {text: "\u{1F525} #{publication.reactions_count}", callback_data: publication.id},
        ].compact
      end

      def host
        return ENV.fetch("APPLICATION_HOST") if Rails.env.production?

        ENV.fetch("APPLICATION_HOST", "localhost:3000")
      end
    end
  end
end
