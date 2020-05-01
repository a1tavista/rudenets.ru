module Api
  module Posts
    class PublicationsController < BaseController
      load_resource :post, class: Publication::Post

      def create
        ::Publications::Publish.new.call(publication_params) do |monad|
          monad.success { |result| @post = result[:publication] }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      def destroy
        ::Publications::Archive.new.call(publication_params) do |monad|
          monad.success { |result| @post = result[:publication] }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      private

      def publication_params
        # params.require(:publication).permit(:slug, :publishing_time).merge(entry: @post.entry)
        {publication: @post}
      end
    end
  end
end
