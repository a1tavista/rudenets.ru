require "dry/transaction/operation"

module ChannelPosts
  module Operations
    class PrerenderPostContent
      include Dry::Transaction::Operation

      def call(input)
        post = input[:channel_post]
        post.update(html_content: render_to_html(post))

        Success(input)
      end

      private

      def render_to_html(post)
        post.content_blocks.map { |block|
          case block["type"]
          when "markdown"
            Kramdown::Document.new(block["value"] || "", TextHelper::PARSER_OPTIONS).to_custom
          when "html"
            block["value"]
          end
        }.join("")
      end
    end
  end
end
