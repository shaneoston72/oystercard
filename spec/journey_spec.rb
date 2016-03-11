
require 'byebug'
require 'journey'


describe Journey do

  subject(:journey) { described_class.new }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }


  context 'initialization' do
    describe '#initialize' do
      it 'returns the entry station name as nil' do
        expect(journey.entry_station).to eq nil
      end
      it 'returns the exit station name as nil' do
        expect(journey.exit_station).to eq nil
      end
    end
  end

  context 'journey management' do
    describe '#start_journey' do
      it 'sets entry station' do
        journey.start_journey(station)
        expect(journey.entry_station).to eq station
      end
    end
    describe '#end_journey' do
      it 'sets exit station' do
        journey.end_journey(station2)
        expect(journey.exit_station).to eq station2
      end
    end
  end

  context 'calculate fare' do
    describe '#fare' do
      it 'calculates minimum fare for complete journey' do
        journey.start_journey(station)
        journey.end_journey(station2)
        expect(journey.fare).to eq Journey::MINIMUM_FARE
      end
      it 'calculates penalty far for incomplete journey' do
        journey.start_journey(station)
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end
end
