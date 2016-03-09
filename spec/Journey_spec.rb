require 'journey'
# require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new "station" }
  # let(:journey) { double(:journey) }

  describe '#initialize' do
    it 'initializes the station' do
      expect(journey.entry_station).to eq "station"
    end

    it 'status of in_journey' do
      expect(journey.status).to eq :in_journey

    end
  end

end
