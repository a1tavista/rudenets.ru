require "telegram/bot"
require "dry/monads"

# TODO: Устранить протекающую абстракцию
class TelegramBot
  include Dry::Monads[:result]
  attr_reader :token, :bot

  def initialize
    @token = ENV.fetch("TELEGRAM_TOKEN", nil)
    @bot = Telegram::Bot::Client.new(@token) if @token.present?
  end

  def set_webhook(url)
    bot.api.set_webhook(url: url)
  rescue => e
    puts e
  end

  def send_message(message, buttons_data:, parse_mode: "HTML")
    result = bot.api.send_message(
      chat_id: chat_id,
      text: message,
      reply_markup: build_inline_keyboard_by(buttons_data),
      parse_mode: parse_mode
    )

    result["ok"] ? Success(message_id: result.dig("result", "message_id"), chat_id: chat_id) : Failure(chat_id)
  rescue => e
    retry if e.respond_to?(:wrapped_exception) && e.wrapped_exception.is_a?(Net::HTTPRetriableError)
    Raven.capture_exception(e)

    Failure(chat_id: chat_id, exception: e)
  end

  def delete_message(message_id)
    result = bot.api.delete_message(
      chat_id: chat_id,
      message_id: message_id,
    )

    result["ok"] ? Success(chat_id: chat_id) : Failure(chat_id)
  rescue => e
    retry if e.respond_to?(:wrapped_exception) && e.wrapped_exception.is_a?(Net::HTTPRetriableError)
    Raven.capture_exception(e)

    Failure(chat_id: chat_id, exception: e)
  end

  def update_message_buttons(message_id, buttons_data:)
    result = bot.api.edit_message_reply_markup(
      chat_id: chat_id,
      message_id: message_id,
      reply_markup: build_inline_keyboard_by(buttons_data),
    )

    result["ok"] ? Success(message_id: message_id, chat_id: chat_id) : Failure(chat_id)
  rescue => e
    retry if e.respond_to?(:wrapped_exception) && e.wrapped_exception.is_a?(Net::HTTPRetriableError)
    Raven.capture_exception(e)

    Failure(chat_id: chat_id, exception: e)
  end

  def answer_to_callback_query(callback_query_id, text: nil)
    bot.api.answer_callback_query(callback_query_id: callback_query_id, text: text)
  end

  def chat_id
    ENV.fetch("TELEGRAM_CHAT_ID", nil)
  end

  private

  def build_inline_keyboard_by(buttons_data)
    Telegram::Bot::Types::InlineKeyboardMarkup.new(
      inline_keyboard: buttons_data.map { |data| Telegram::Bot::Types::InlineKeyboardButton.new(data) }
    )
  end
end
