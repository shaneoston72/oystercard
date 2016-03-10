
require 'byebug'
require 'journey'


describe Journey do

  subject(:journey) { described_class.new("aldgate") }


  context 'initialization' do
    describe '#initialize' do
      it 'returns the station name' do
        expect(journey.entry_station).to eq "aldgate"
      end
    end
  end

  context 'start a journey' do
    describe '#start_journey' do
      it 'creates the first half of the journey record' do
        journey.start_journey
        expect(journey.journey_record).to include( :in =>"aldgate" )
      end
    end
  end
end
