module TelegramChannelHandlers
  class NotifyChannel < BaseHandler
    attr_reader :bot

    delegate :url_helpers, to: 'Rails.application.routes'

    def handle_event
      @bot = TelegramBot.new

      case event.type
      when 'Events::PostPublished'
        notify_about_post
      when 'Events::LinkPublished'
        notify_about_link
      end
    end

    private

    def host
      return ENV.fetch('APPLICATION_HOST') if Rails.env.production?

      ENV.fetch('APPLICATION_HOST', 'localhost:3000')
    end

    def notify_about_post
      post = Post.find(event.data[:post_id])
      url = url_helpers.post_url(post, host: host)

      TelegramBot.new.notify([
        "\u{2B50} Новая публикация в блоге \u{2B50}",
        "\n<b><a href=\"#{url}\">#{post.title}</a></b>",
        "\n#{post.summary}"
      ].compact.join("\n"))
    end

    def notify_about_link
      link = Link.find(event.data[:link_id])
      url = url_helpers.go_links_url(url: link.url, host: host)

      TelegramBot.new.notify([
        "\u{2615} Рекомендация: <b><a href=\"#{url}\">#{link.title}</a></b>",
        ("\n<i>#{link.description}</i>" unless link.description.blank?),
        ("\n--------------\n\n#{link.summary}" unless link.summary.blank?)
      ].compact.join("\n"))
    end
  end
end
