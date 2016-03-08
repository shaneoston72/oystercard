require './lib/oystercard'

p oyster = Oystercard.new

p oyster.balance

p oyster.top_up (8)

p oyster.top_up(2)

p oyster.in_journey?

p oyster.touch_in

p oyster.touch_out
