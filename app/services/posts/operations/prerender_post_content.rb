require "dry/transaction/operation"

module Posts
  module Operations
    class PrerenderPostContent
      include Dry::Transaction::Operation

      def call(input)
        post = input[:post]

        # TODO: Replace with dry-view
        content = prepare_content(post)
        reading_time = calculate_reading_time(post)

        post.update(
          prerendered_content: content,
          meta_data: {reading_time: reading_time}
        )

        Success(input)
      end

      private

      def calculate_reading_time(post)
        words_per_minute = 180

        words = post.content_blocks.select { |b| b["type"] == "markdown" }.map { |b| b["value"] }.join("\n").split
        (words.size / words_per_minute).floor
      end

      def prepare_content(post)
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
