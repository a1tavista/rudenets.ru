class BaseHandler
  include Sidekiq::Worker

  attr_reader :event

  sidekiq_options queue: :event_queue, retry: false

  def perform(payload)
    @event = Rails.configuration.event_store.deserialize(payload.transform_keys(&:to_sym))
    handle_event
  rescue NotImplementedError
    Rails.logger.fatal "#{self.class} is not implemented yet"
  end

  def self.handle_by_event_id(event_id)
    event = Rails.configuration.event_store.read.event(event_id)
    serialized_event = RubyEventStore::Mappers::Default.new.event_to_serialized_record(event)
    perform_async(serialized_event.to_h)
  end

  protected

  def event_store
    Rails.configuration.event_store
  end
end
