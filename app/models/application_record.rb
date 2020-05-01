class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.primary_key_as_foreign
    [to_s.demodulize.underscore, primary_key].join("_").to_sym
  end

  def event_store
    Rails.configuration.event_store
  end

  def event_stream
    event_store.read.stream(stream_name)
  end

  def publish_event(klass, data = {})
    data = data.merge(Hash[self.class.primary_key_as_foreign, id])
    event = klass.new(data: data)
    event_store.publish(event, stream_name: stream_name)
  end

  def stream_name
    [channel_name, id].join(":")
  end

  def channel_name
    self.class.to_s.demodulize
  end
end
