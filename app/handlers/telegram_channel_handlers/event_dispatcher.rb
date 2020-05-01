module TelegramChannelHandlers
  class EventDispatcher < BaseDispatcher
    PRIME_TIME_INTERVALS = [
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["17:00", "21:30"],
      ["17:00", "21:30"],
    ].freeze

    EVENT_DISPATCHING_RULES = {
      "Events::PostPublished" => [
        {handler: TelegramChannelHandlers::NotifyChannel::NewPost, when: ->(d) { d.prime_time }},
      ],
      "Events::LinkPublished" => [
        {handler: TelegramChannelHandlers::NotifyChannel::NewLink, when: ->(d) { d.prime_time }},
      ],
      "Events::ChannelPostPublished" => [
        {handler: TelegramChannelHandlers::NotifyChannel::NewChannelPost, when: ->(d) { Time.current }},
      ],
      "Events::ReactionReceived" => [
        {handler: TelegramChannelHandlers::NotifyChannel::UpdateMessageButtons, when: ->(d) { Time.current }},
      ],
    }.freeze

    def prime_time
      PrimeTime.prime_time(Time.current, schedule: self.class::PRIME_TIME_INTERVALS)
    end
  end
end
