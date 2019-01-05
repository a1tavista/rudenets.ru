module Api
  class PagesController < BaseController
    load_resource

    def index
      respond_with(@pages)
    end

    def update
      @page.update(page_params)
    end

    private

    def page_params
      params.require(:page).permit(:id, :url, :title, :content)
    end
  end
end
