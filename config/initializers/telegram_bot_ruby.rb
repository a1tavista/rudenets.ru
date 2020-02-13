require 'telegram/bot'

Faraday::Adapter.register_middleware telegram_proxy_adapter: TelegramProxyAdapter
Telegram::Bot.configure do |config|
  config.adapter = :telegram_proxy_adapter
end
