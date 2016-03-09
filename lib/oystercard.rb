require 'journey'

class Oystercard

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  attr_reader :balance, :journeys

  def initialize(journey_class: Journey)
    @balance = 0
    @journeys = {}
    @journey_class = journey_class

  end

  def top_up(amount)
    fail "Card balance may not exceed £#{CARD_LIMIT}" if exceeds_max?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "This card is already in journey." if in_journey?
    fail "Card balance is too low." if below_min?
    @current_journey  = @journey_class.new station
  end

  def touch_out(station)
    fail "This card is not in journey." unless in_journey?
    deduct(MIN_AMOUNT)
    # @entry_station = nil
    # @journeys[journey_index][:out] = station
  end

  def increment_journey_index
    @journey_index += 1
  end

  private

    def in_journey?
      @status
    end

    def exceeds_max?(amount)
      amount + balance > CARD_LIMIT
    end

    def below_min?
      @balance < MIN_AMOUNT
    end

    def deduct(amount)
      @balance -= amount
    end
end
