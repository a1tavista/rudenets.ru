require "dry/monads"

module Entries
  class PublishEntry
    include Dry::Transaction
    include Dry::Monads[:maybe]

    step :initialize_records
    step :validate_entry
    map :prepare_taxonomy
    step :publish_entry
    tee :publish_event

    def initialize_records(input)
      maybe_entry_from(input).fmap { |entry|
        {
          entry: entry,
          publishing_time: set_publishing_time_for(entry, publishing_time: input[:publishing_time]),
          slug: input[:slug],
        }
      }.to_result
    end

    def validate_entry(input)
      type = input[:entry].taxonomy_type
      attributes = input[:entry].taxonomy.attributes
      result = "#{type}Schema::Strict".constantize.new.call(attributes)
      result.success? ? Success(input) : Failure(errors: result.errors.messages, code: :validation_fault)
    end

    def prepare_taxonomy(input)
      return input unless input[:entry].taxonomy_type == "Post"

      Posts::Operations::UpdateSlug.new.call(input.merge(post: input[:entry]))
      input
    end

    def publish_entry(input)
      input[:entry].update(published_at: input[:publishing_time])

      Success(input)
    end

    def publish_event(input)
      input[:entry].taxonomy.publish_event("Events::#{input[:entry].taxonomy_type}Published".constantize)
    end

    private

    def maybe_entry_from(input)
      Maybe(input[:entry]).or { Maybe(Publication.find_by(input[:entry_find_by])) }
    end

    def set_publishing_time_for(entry, publishing_time: nil)
      Maybe((Time.parse(publishing_time) if publishing_time.present?))
        .value_or { Maybe(entry.published_at) }
        .value_or { Time.current }
    end
  end
end
