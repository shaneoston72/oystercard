class Journey

  attr_reader :entry_station, :status

  def initialize station
    @entry_station = station
    @status = :in_journey
  end

end
