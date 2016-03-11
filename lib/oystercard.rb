
require_relative 'journey_log'
require_relative 'station'

class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize(log = JourneyLog)
    @balance = 0
    @log = log.new
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Error insufficient funds" if @balance < MIN_LIMIT
    deduct(@log.journey_history.last.fare) if !@log.journey_history.empty? && @log.journey_history.last.exit_station == nil
    @log.start(station)
  end

  def touch_out(station)
    @log.finish(station)
    deduct(@log.journey_history.last.fare)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
