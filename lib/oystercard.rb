require 'byebug'
require_relative 'journey'

class Oystercard
  attr_reader :balance,  :journeys

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = Array.new
    @journey_class = journey_class
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Error insufficient funds" if @balance < MIN_LIMIT
    deduct(@journeys.last.fare) if !@journeys.empty? && @journeys.last.exit_station == nil
    current_journey = @journey_class.new
    current_journey.start_journey(station)
    @journeys << current_journey
  end

  def touch_out(station)
    if @journeys.empty? || @journeys.last.exit_station
      @journeys << @journey_class.new
    end
    @journeys.last.end_journey(station)
    deduct(@journeys.last.fare)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
