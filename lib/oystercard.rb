class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Limit is £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def debit(fare)
    @balance -= fare
  end

  def tap_in
    @in_journey = true
    # self.in_journey?
  end

  def tap_out
    @in_journey = false
  end

  # private

  # attr_reader :in_journey

  def in_journey?
    @in_journey
  end

end
