class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Limit is £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end


  def tap_in(station)
    @entry_station = station
    raise "Balance less than £#{MIN_BALANCE} - NO ENTRY" if @balance < MIN_BALANCE
  end

  def tap_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  # private

  # attr_reader :in_journey

  def in_journey?
    @entry_station == nil ? false : true
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
