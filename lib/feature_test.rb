require './lib/oystercard'
require './lib/station'
station = Station.new

p = Station.new
p oyster = Oystercard.new

p oyster.balance

p oyster.top_up (8)

p oyster.top_up(2)

p oyster.in_journey?

p oyster.touch_in(station)

p oyster.touch_out(station)

p oyster.journey_history
