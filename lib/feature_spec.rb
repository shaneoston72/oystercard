require_relative 'oystercard'

p card = Oystercard.new
p 1
p card.entry_station
p 2

card.top_up(20)

card.tap_in("Shoreditch")
p 3
p card.entry_station

p card.in_journey?
