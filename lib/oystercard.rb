class Oystercard

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Card balance may not exceed £#{CARD_LIMIT}" if exceeds_max?(amount)
    @balance += amount
  end

  def touch_in
    fail "This card is already in journey." if in_journey?
    fail "Card balance is too low." if below_min?
    @in_journey = true
  end

  def touch_out
    fail "This card is not in journey." unless in_journey?
    deduct(MIN_AMOUNT)
    @in_journey = false
  end

  private

    def in_journey?
      @in_journey
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
