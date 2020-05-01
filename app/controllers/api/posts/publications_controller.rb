module Api
  module Posts
    class PublicationsController < BaseController
      load_resource :post, class: Publication::Post

      def create
        ::Entries::PublishEntry.new.call(publication_params) do |monad|
          monad.success { |result| @post = result[:entry].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      def destroy
        ::Entries::ArchiveEntry.new.call(publication_params) do |monad|
          monad.success { |result| @post = result[:post].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      private

      def publication_params
        {entry: @post}
        # params.require(:publication).permit(:slug, :publishing_time).merge(entry: @post.entry)
      end
    end
  end
end
