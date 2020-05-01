require "dry/monads"

module Publications
  class Publish
    include Dry::Transaction
    include Dry::Monads[:maybe]

    step :initialize_records
    step :validate_entry
    map :prepare_publication
    step :publish
    tee :send_event

    def initialize_records(input)
      maybe_entry_from(input).fmap { |publication|
        {
          publication: publication,
          publishing_time: set_publishing_time_for(publication, publishing_time: input[:publishing_time]),
          slug: input[:slug],
        }
      }.to_result
    end

    def validate_entry(input)
      type = input[:publication].taxonomy_type
      attributes = input[:publication].attributes
      result = "#{type}Schema::Strict".constantize.new.call(attributes)
      result.success? ? Success(input) : Failure(errors: result.errors.messages, code: :validation_fault)
    end

    def prepare_publication(input)
      return input unless input[:publication].post?

      Posts::Operations::UpdateSlug.new.call(input.merge(post: input[:publication]))
      input
    end

    def publish(input)
      input[:publication].update(published_at: input[:publishing_time])

      Success(input)
    end

    def send_event(input)
      input[:publication].publish_event("Events::#{input[:publication].taxonomy_type}Published".constantize)
    end

    private

    def maybe_entry_from(input)
      Maybe(input[:publication]).or { Maybe(Publication.find_by(input[:publication_find_by])) }
    end

    def set_publishing_time_for(publication, publishing_time: nil)
      Maybe((Time.parse(publishing_time) if publishing_time.present?))
        .value_or { Maybe(publication.published_at) }
        .value_or { Time.current }
    end
  end
end
