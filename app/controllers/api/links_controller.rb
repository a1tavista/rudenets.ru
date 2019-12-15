module Api
  class LinksController < BaseController
    load_resource except: [:new, :create]

    def new
      ::Links::ParseLink.new.call(url: params[:url]) do |monad|
        monad.success { |result| @opengraph = result[:opengraph] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def create
      ::Links::CreateLink.new.call(attributes: link_params.to_h) do |monad|
        monad.success { |result| @link = result[:link] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def update
      ::Links::UpdateLink.new.call(link: @link, attributes: link_params.to_h) do |monad|
        monad.success { |result| @link = result[:link] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def destroy
      @link.destroy
    end

    private

    def link_params
      params.require(:link).permit!
    end
  end
end
