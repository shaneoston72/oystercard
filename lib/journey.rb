class Journey

  attr_reader :entry_station, :status

  def initialize station
    @entry_station = station
    @status = :in_journey
  end

  def begin
    journey_start(@entry_station)
  end

  private

    def journey_start(station)
      journey = {}
      journey[Time.now.strftime("%H:%M:%S")] = { :in => station}
      journey
    end


end
