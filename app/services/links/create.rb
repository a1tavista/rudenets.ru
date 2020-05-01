module Links
  class Create
    include Dry::Transaction

    step :validate
    step :create_link
    tee :publish_event

    def validate(input)
      result = LinkSchema.new.call(input[:attributes])
      return Failure(errors: result.errors) unless result.success?

      Success(input.merge(attributes: result.to_h))
    end

    def create_link(input)
      attributes = input[:attributes].transform_values { |v| v.presence }

      link = Publication::Link.new(attributes.except(:cover_image_url))

      link.publication_data = {}
      link.html_content = prerender_link_content(link)
      link.cover_image = Down.open(attributes[:cover_image_url]) if correct_image_url?(attributes[:cover_image_url])
      link.published_at = Time.current

      link.save!

      Success(input.merge(publication: link))
    end

    def correct_image_url?(url)
      return false if url.blank?

      url.start_with?("http://", "https://")
    end

    def prerender_link_content(link)
      markdown = link.content_blocks.first.dig("value")
      return if markdown.presence.nil?

      Kramdown::Document.new(markdown, TextHelper::PARSER_OPTIONS).to_custom
    end

    def publish_event(input)
      input[:publication].publish_event(Events::LinkPublished)
    end
  end
end
