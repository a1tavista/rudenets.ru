require "dry/transaction/operation"

module Posts
  module Operations
    class CacheContent
      include Dry::Transaction::Operation

      def call(input)
        publication = input[:publication]

        content = render_to_html(publication)
        reading_time = calculate_reading_time(publication)

        publication.update(
          html_content: content,
          meta_data: {reading_time: reading_time}
        )

        Success(input)
      end

      private

      def calculate_reading_time(publication)
        words_per_minute = 180

        words = publication.content_blocks.select { |b| b["type"] == "markdown" }.map { |b| b["value"] }.join("\n").split
        (words.size / words_per_minute).floor
      end

      def render_to_html(publication)
        publication.content_blocks.map { |block|
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
