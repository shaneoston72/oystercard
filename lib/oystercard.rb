class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Limit is £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end


  def tap_in
    raise "Balance less than £#{MIN_BALANCE} - NO ENTRY" if @balance < MIN_BALANCE
    @in_journey = true

  end

  def tap_out
    deduct(2)
    @in_journey = false
  end

  # private

  # attr_reader :in_journey

  def in_journey?
    @in_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end

