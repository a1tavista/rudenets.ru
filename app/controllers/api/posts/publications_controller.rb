module Api
  module Posts
    class PublicationsController < BaseController
      load_resource :post

      def create
        prepare = ->(input) do
          post = input[:entry].taxonomy

          slug_date = I18n.l(input[:publishing_time], format: :slug)
          slug_title = Russian.translit(post.title).parameterize.downcase
          post.update_columns(slug: "#{slug_date}-#{slug_title}")

          input
        end

        ::Entries::PublishEntry.new(prepare_taxonomy: prepare).call(entry: @post.entry) do |monad|
          monad.success { |result| @post = result[:entry].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      def destroy
        ::Entries::ArchiveEntry.new.call(entry: @post.entry) do |monad|
          monad.success { |result| @post = result[:post].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end
    end
  end
end
