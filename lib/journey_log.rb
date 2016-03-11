require_relative 'journey'

class JourneyLog 

	def initialize(journey_class = Journey)
		@journey_history = Array.new
		@journey_class = journey_class
	end

	def start(at_station)
		this_journey = @journey_class.new
    	this_journey.start_journey(at_station)
    	@journey_history << this_journey
	end

	def finish(at_station)
		current_journey.end_journey(at_station)

	end

	def journey_history
		@journey_history.dup
	end

	private	

	def current_journey
		if @journey_history.empty? || @journey_history.last.exit_station
			@journey_history << @journey_class.new
		end
		@journey_history.last
	end


end