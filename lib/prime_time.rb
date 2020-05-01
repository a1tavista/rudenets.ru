module PrimeTime
  def self.prime_time(current_time, schedule:)
    return Time.current if ENV["DISABLE_DELAYED_PUBLICATIONS"]

    publishing_time = time_to_next_quarter_hour(current_time)
    acceptable_time = acceptable_time_for(current_time, schedule: schedule)

    return publishing_time.beginning_of_minute if acceptable_time.include?(publishing_time)

    # Если за границей текущего, то возвращаем первый слот со следующего дня
    publishing_time > acceptable_time.end ?
        acceptable_time_for(current_time, schedule: schedule, gap: 1.day).begin :
        acceptable_time.begin
  end

  def self.acceptable_time_for(time, schedule:, gap: 0.days)
    Range.new(*schedule[time.wday - 1].map { |t| Time.zone.parse(t) + gap })
  end

  def self.time_to_next_quarter_hour(time)
    array = time.to_a
    quarter = ((array[1] % 60) / 15.0).ceil
    array[1] = (quarter * 15) % 60
    Time.zone.local(*array) + (quarter == 4 ? 3600 : 0)
  end
end
