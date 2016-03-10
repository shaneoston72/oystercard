
require 'byebug'
require 'journey'


describe Journey do

  subject(:journey) { described_class.new(entry_station) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station2) }


  context 'initialization' do
    describe '#initialize' do
      it 'returns the station name' do
        expect(journey.entry_station).to eq entry_station
      end
    end
  end

  context 'start a journey' do
    describe '#start_journey' do
      it 'creates the first half of the journey record' do
        journey.start_journey
        expect(journey.journey_record).to include( :in =>entry_station )
      end
    end
  end

  context 'complete a journey' do
    describe '#end_journey' do
      it 'adds the end of the journey to the journey record' do
        journey.start_journey
        journey.end_journey(exit_station)
        expect(journey.journey_record).to include( :in=>entry_station, :out=>exit_station )
      end
    end
  end
end
