class Publication
  class Link < Publication
    def host
      URI.parse(source_url).host
    end
  end
end
