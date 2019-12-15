module Entries
  class PublishEntry
    include Dry::Transaction

    map :initialize_records
    step :validate_entry
    map :prepare_taxonomy
    step :publish_entry

    def initialize_records(input)
      {
        entry: input[:entry] || Entry.find_by(input[:entry_find_by]),
        publishing_time: input[:publishing_time].blank? ? Time.current : Time.parse(input[:publishing_time])
      }
    end

    def validate_entry(input)
      type = input[:entry].taxonomy_type
      attributes = input[:entry].taxonomy.attributes
      result = "#{type}Schema::Strict".constantize.new.call(attributes)
      result.success? ? Success(input) : Failure(errors: result.errors.messages, code: :validation_fault)
    end

    def publish_entry(input)
      input[:entry].update(published: true, published_at: input[:publishing_time])

      Success(input)
    end

    private

    def prepare_taxonomy(input)
      input
    end
  end
end
