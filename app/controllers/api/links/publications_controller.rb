module Api
  module Links
    class PublicationsController < BaseController
      def create
        ::Publications::Publish.new.call(publication: @link) do |monad|
          monad.success { |result| @link = result[:publication] }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      def destroy
        ::Publications::Archive.new.call(publication: @link) do |monad|
          monad.success { |result| @link = result[:publication] }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end
    end
  end
end
