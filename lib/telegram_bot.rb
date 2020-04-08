require "telegram/bot"

class TelegramBot
  attr_reader :token, :bot

  def initialize
    @token = ENV.fetch("TELEGRAM_TOKEN", nil)
    @bot = Telegram::Bot::Client.new(@token) if @token.present?
  end

  def notify(message, chat_id: nil)
    bot.api.send_message(
      chat_id: chat_id || ENV.fetch("TELEGRAM_CHAT_ID", nil),
      text: message,
      parse_mode: "HTML"
    )
  rescue => e
    retry if e.respond_to?(:wrapped_exception) && e.wrapped_exception.is_a?(Net::HTTPRetriableError)
    Raven.capture_exception(e)
  end
end