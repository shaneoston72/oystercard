class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2

  def initialize
    @balance = 0
    @journey_history = {}
  end

  def top_up(amount)
    error = "Limit is £#{MAX_BALANCE}"
    raise error if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end


  def tap_in(station)
    @entry_station = station
    error = "Balance less than £#{MIN_BALANCE} - NO ENTRY"
    raise error if @balance < MIN_BALANCE
  end

  def tap_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    log
    @entry_station = nil


  end

  def in_journey?
    @entry_station == nil ? false : true
  end


  private

  def deduct(fare)
    @balance -= fare
  end

  def log
    key = "#{Time.now.day}/#{Time.now.month}/#{Time.now.year}"
    @journey_history[key] = [@entry_station, @exit_station]
  end

end
