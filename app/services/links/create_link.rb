module Links
  class CreateLink
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

      link = Link.new(attributes.except(:image_url))
      link.image = Down.open(attributes[:image_url]) unless attributes[:image_url].blank?
      link.entry_attributes = {published: true, published_at: Time.current}
      link.save!

      Success(input.merge(link: link))
    end

    def publish_event(input)
      input[:link].publish_event(Events::LinkPublished)
    end
  end
end
