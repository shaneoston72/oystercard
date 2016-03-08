require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  describe '#journey_log' do
    it "1.0 works" do
      shoreditch = Station.new("Shoreditch", 1)
      hoxton = Station.new("Hoxton", 2)
      card = Oystercard.new

      card.top_up(20)
      card.tap_in(shoreditch)
      card.tap_out(hoxton)

      expect(card.journey_history).to eq start: "Shoreditch", end: "Hoxton"
    end
  end


end
