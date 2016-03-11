require 'byebug'
require 'oystercard'

describe Oystercard do
  let(:journey) { double :journey }
  let(:journey_class) { double(:journey_class, new: journey) }
  subject(:card) { described_class.new journey_class }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  context "#initialize" do
    describe 'initalize#balance' do
      it 'checks that new card has a balance' do
        expect(card.balance).to eq 0
      end
      it 'has an empty list of journeys' do
        expect(card.journeys).to be_empty
      end
    end
  end

  describe '#top_up' do
    it 'it adds 20 to balance' do
      card.top_up(20)
      expect(card.balance).to eq 20
    end

    it 'raises an error if balance exceeds limit' do
      message = "Error, balance exceeds £#{Oystercard::MAX_LIMIT}!"
      expect{ card.top_up(100) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'raises error when balance insufficient' do
      expect{ card.touch_in(station) }.to raise_error "Error insufficient funds"
    end

    it 'creates a new journey stored in journeys' do
      card.top_up(20)
      expect(journey).to receive(:start_journey).with(station)
      expect{ card.touch_in(station) }.to change{ card.journeys.length }.by 1
    end

    it 'deducts penalty fare when there is no touch out on last journey' do
      card.top_up 20
      allow(journey).to receive(:start_journey).with(station)
      allow(journey).to receive(:exit_station)
      allow(journey).to receive(:fare).and_return(Journey::PENALTY_FARE)
      card.touch_in(station)
      expect{ card.touch_in(station) }.to change{ card.balance }.by -(Journey::PENALTY_FARE)
    end

  end

  describe '#touch_out' do
   it 'deducts fare from balance' do
     card.top_up 20
     allow(journey).to receive(:end_journey).with(station2)
     allow(journey).to receive(:start_journey).with(station)
     allow(journey).to receive(:exit_station)
     allow(journey).to receive(:fare).and_return(Journey::MINIMUM_FARE)
     card.touch_in(station)
     expect{ card.touch_out(station2) }.to change{ card.balance }.by -(Journey::MINIMUM_FARE)
   end
   it 'deducts penalty fare when no touch in' do
     card.top_up 20
     allow(journey).to receive(:end_journey).with(station2)
     allow(journey).to receive(:exit_station)
     allow(journey).to receive(:fare).and_return(Journey::PENALTY_FARE)
     expect{ card.touch_out(station2) }.to change{ card.balance }.by -(Journey::PENALTY_FARE)
   end
   it 'creates a new journey in journeys for penalty journey' do
     card.top_up 20
     allow(journey).to receive(:end_journey).with(station2)
     allow(journey).to receive(:exit_station)
     allow(journey).to receive(:fare).and_return(Journey::PENALTY_FARE)
     expect{ card.touch_out(station2) }.to change{ card.journeys.length }.by 1
   end
  end
end
