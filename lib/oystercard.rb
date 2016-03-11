
require_relative 'journey_log'
require_relative 'station'

class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize(log_class = JourneyLog)
    @balance = 0
    @log_class = log_class.new
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Error insufficient funds" if @balance < MIN_LIMIT
    deduct(@log_class.journey_history.last.fare) if !@log_class.journey_history.empty? && @log_class.journey_history.last.exit_station == nil
    @log_class.start(station)
  end

  def touch_out(station)
    @log_class.finish(station)
    deduct(@log_class.journey_history.last.fare)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
