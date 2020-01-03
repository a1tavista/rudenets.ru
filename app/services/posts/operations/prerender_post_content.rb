require "dry/transaction/operation"

module Posts
  module Operations
    class PrerenderPostContent
      include Dry::Transaction::Operation

      def call(input)
        post = input[:post]

        # TODO: Replace with dry-view
        content = post.content_blocks.map do |block|
          case block['type']
          when 'markdown'
            Kramdown::Document.new(block['value'] || '', TextHelper::PARSER_OPTIONS).to_custom
          when 'html'
            block['value']
          end
        end.join('')
        post.update(prerendered_content: content)

        Success(input)
      end
    end
  end
end
