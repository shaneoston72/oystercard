require 'byebug'
require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new  }
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
    it 'card is in journey' do
      allow(card).to receive(:in_journey?).and_return(true)
      expect{ card.touch_in(station) }.to raise_error "This card is in a journey"
    end

    it 'raises error when balance insufficient' do
      allow(card).to receive(:in_journey?).and_return(false)
      expect{ card.touch_in(station) }.to raise_error "Error insufficient funds"
    end

    # it 'tells Journey to start a journey instance' do
    # it 'remembers entry station' do
    #   allow(card).to receive(:in_journey?).and_return(false)
    #   card.top_up(20)
    #   card.touch_in(station)
    #   expect(card.journeys).to include ({ :in => station } )
    # end

  end

  describe '#touch_out' do
    it 'card is not in journey' do
      allow(card).to receive(:in_journey?).and_return(false)
      card.top_up(20)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.in_journey?).to eq false
    end

   it 'deducts fare from balance' do
     expect{ card.touch_out(station) }.to change{ card.balance }.by -3
   end

   it 'forgets the entry station on touch out' do
     allow(card).to receive(:in_journey?).and_return(false)
     card.top_up(20)
     card.touch_in(station)
     card.touch_out(station2)
     expect(card.in_journey?).to eq false
   end

   it 'remembers exit station' do
     allow(card).to receive(:in_journey?).and_return(false)
     card.top_up(20)
     card.touch_in(station)
     card.touch_out(station2)
     expect(card.journeys).to include ({ :in => station, :out => station2 } )
   end
  end
end
