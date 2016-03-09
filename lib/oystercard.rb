class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false

  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
