require 'byebug'
require 'oystercard'

describe Oystercard do
  let(:journey) { double :journey }
  let(:journeylog) {double :JourneyLog}
  let(:log) { double :log, new: journeylog }  
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }
  subject(:card) { described_class.new }

  context "#initialize" do
    describe 'initalize#balance' do
      it 'checks that new card has a balance' do
        expect(card.balance).to eq 0
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

    it 'deducts penalty fare when there is no touch out on last journey' do
      card.top_up 20
      #allow(log).to receive(:start).with(station)
      #allow(log).to receive(:finish).with(station2)
      #allow(log).to receive(:journey_history).with(station2)
      allow(journey).to receive(:fare).and_return(Journey::PENALTY_FARE)
      card.touch_in(station)
      expect{ card.touch_in(station) }.to change{ card.balance }.by -(Journey::PENALTY_FARE)
    end

  end

  describe '#touch_out' do
   it 'deducts fare from balance' do
     card.top_up 20
     allow(journey).to receive(:fare).and_return(3)
     card.touch_in(station)
     expect{ card.touch_out(station2) }.to change{ card.balance }.by -3
   end

  end

end
