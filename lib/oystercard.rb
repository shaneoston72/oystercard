class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@in_journey
  end

  def touch_in
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    @in_journey = true
  end

  def touch_out
    deduct(3)
    @in_journey = false
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
