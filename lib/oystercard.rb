class Oystercard

attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    if amount > 90 || @balance + amount > 90
      raise "exceeded max top up"
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end
end
