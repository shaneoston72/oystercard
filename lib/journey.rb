class Journey

  attr_reader :entry_station, :status

  def initialize station
    @entry_station = station
    @status = :in_journey
    start_journey
  end

  def start_journey
    journey_start(@entry_station)
  end

  def end_journey(station)
    journey_end(station)
  end

  def fare
    calculate_fare
  end

  private

    attr_reader :start_time

    def time
      Time.now.strftime("%H:%M:%S")
    end

    def journey_start(station)
      @journey = {}
      @start_time = time
      @journey[@start_time] = { :in => station }
      @journey
    end

    def journey_end(station)
      @journey[@start_time][:out] = station
      @journey
    end

    def calculate_fare
      # if @journey is complete
      #   @journey[@start_time][:fare] = 1
      # else
      #   something else
      # end
    end

end
