module Api
  class PagesController < BaseController
    load_resource

    def index
      respond_with(@pages)
    end

    def update
      @page.update(page_params)
      @page.update(html_content: content_blocks_to_html(@page))
    end

    private

    def content_blocks_to_html(page)
      page.content_blocks.map { |block|
        case block["type"]
        when "markdown"
          Kramdown::Document.new(block["value"] || "", TextHelper::PARSER_OPTIONS).to_custom
        when "html"
          block["value"]
        end
      }.join("")
    end

    def page_params
      params.require(:page).permit(:id, :url, :title, :custom_css, content_blocks: [:type, :value])
    end
  end
end
