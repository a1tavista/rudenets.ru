class BaseDispatcher < BaseHandler
  EVENT_DISPATCHING_RULES = {}.freeze

  def handle_event
    self.class::EVENT_DISPATCHING_RULES.fetch(event.type).each { |handler_rule| send_to_handler(handler_rule) }
  end

  private

  def send_to_handler(handler_rule)
    if handler_rule[:when] == :now
      handler_rule[:handler].perform_async(event.event_id)
    else
      handler_rule[:handler].perform_at(handler_rule[:when].call(self), event.event_id)
    end
  end
end
