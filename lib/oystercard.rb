class Oystercard

attr_reader :balance, :in_journey


  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    if amount > 90 || @balance + amount > 90
      raise "exceeded max top up"
    else
      @balance += amount
    end
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
  
end
