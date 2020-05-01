class Publication
  class Link < Publication
    def notion
      content_blocks.first&.dig("value")
    end

    def host
      URI.parse(source_url).host
    end
  end
end
