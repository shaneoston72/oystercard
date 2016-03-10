class Oystercard
  attr_reader :balance,  :journeys

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @journeys = Array.new
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    @journeys.select { |journey| journey.key?(:out) }.empty?
  end

  def touch_in(station)
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    @journeys << { :in => station }
  end

  def touch_out(station)
    deduct(3)
    @exit_station = station
    @journeys.last[:out] = station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
