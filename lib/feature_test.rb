require './lib/oystercard'

p oyster = Oystercard.new

p oyster.balance

p oyster.top_up(10)

p oyster.top_up(100)
