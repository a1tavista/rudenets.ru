class TelegramProxyAdapter < Faraday::Adapter::NetHttp
  def net_http_connection(env)
    Net::HTTP.new(
      env[:url].hostname,
      env[:url].port || (env[:url].scheme == 'https' ? 443 : 80),
      ENV.fetch('TELEGRAM_PROXY_IP', nil),
      ENV.fetch('TELEGRAM_PROXY_PORT', nil),
      ENV.fetch('TELEGRAM_PROXY_USERNAME', nil),
      ENV.fetch('TELEGRAM_PROXY_PASSWORD', nil),
    )
  end
end
