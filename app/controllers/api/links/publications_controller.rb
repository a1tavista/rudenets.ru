module Api
  module Links
    class PublicationsController < BaseController
      def create
        ::Entries::PublishEntry.new.call(entry: @link.entry) do |monad|
          monad.success { |result| @link = result[:link].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end

      def destroy
        ::Entries::ArchiveEntry.new.call(entry: @link.entry) do |monad|
          monad.success { |result| @link = result[:link].taxonomy }
          monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
        end
      end
    end
  end
end
