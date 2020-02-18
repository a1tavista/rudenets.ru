module TelegramChannelHandlers
  class EventDispatcher < BaseDispatcher
    PRIME_TIME_INTERVALS = [
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["17:00", "21:30"],
      ["17:00", "21:30"]
    ].freeze

    EVENT_DISPATCHING_RULES = {
      'Events::PostPublished' => [
        { handler: TelegramChannelHandlers::NotifyChannel::NewPost, when: ->(d) { d.prime_time } }
      ],
      'Events::LinkPublished' => [
        { handler: TelegramChannelHandlers::NotifyChannel::NewLink, when: ->(d) { d.prime_time } }
      ]
    }.freeze

    def prime_time
      publishing_time = time_to_next_quarter_hour(Time.current)
      acceptable_time = acceptable_time_for(Time.current)

      return publishing_time.beginning_of_minute if acceptable_time.include?(publishing_time)

      # Если за границей текущего, то публикуем на следующий день
      publishing_time > acceptable_time.end ? acceptable_time_for(Time.current, gap: 1.day).begin : acceptable_time.begin
    end

    private

    def acceptable_time_for(time, gap: 0.days)
      Range.new(*self.class::PRIME_TIME_INTERVALS[time.wday - 1].map { |t| t.to_time + gap })
    end

    def time_to_next_quarter_hour(time)
      array = time.to_a
      quarter = ((array[1] % 60) / 15.0).ceil
      array[1] = (quarter * 15) % 60
      Time.local(*array) + (quarter == 4 ? 3600 : 0)
    end
  end
end
