require 'byebug'
class Journey

  attr_reader :entry_station, :journey_record

  def initialize(station)
    @entry_station = station
    @journey_record = Hash.new
  end

  def start_journey
    @journey_record[:in] = @entry_station
  end

end
