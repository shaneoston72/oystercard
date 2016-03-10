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
    fail "This card is in a journey" if in_journey?
    fail "Error insufficient funds" if @balance < MIN_LIMIT
    #  need to tell Journey to start a journey here
    # Journey.new(station)
    @journeys << { :in => station }
  end

  def touch_out(station)
    deduct(3)
    @exit_station = station
    # tell Journey to complete journey
    @journeys.last[:out] = station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
