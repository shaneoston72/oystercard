require_relative 'station'

class Oystercard

attr_reader :balance, :in_journey, :entry_station, :exit_station, :current_journey, :journey_history

MIN_BALANCE = 1
MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = ''
    @exit_station = ''
    @journey_history =[]
  end

  def top_up(amount)
    if amount > MAX_BALANCE || @balance + amount > MAX_BALANCE
      raise "exceeded max top up"
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    if @balance > MIN_BALANCE
       @in_journey = true
       @entry_station = station
       @current_journey
    else
      raise "not enough funds"
    end
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @in_journey = false
    @exit_station = station
    @current_journey = { @entry_station => @exit_station }
    @journey_history << @current_journey



  end




end
