# in spec/Oystercard_spec.rb
require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new journey_class: journey }
  let(:station) { double(:station)}
  let(:station2) { double(:station)}
  let(:journey) { double(:journey) }

  context 'Oystercard balance' do
    describe '#card_balance' do
      it "should show the card's initial balance" do
        expect(card.balance).to eq 0
      end
    end

    describe '#top_up' do
      it "should top up the card" do
        expect{ card.top_up 10 }.to change{ card.balance }.by 10
      end
      it 'should raise an error if new balance would be greater than £90' do
        max_balance = Oystercard::CARD_LIMIT
        card.top_up(max_balance)
        expect{ card.top_up 1 }.to raise_error "Card balance may not exceed £#{max_balance}"
      end
    end

    # describe "#deduct" do
    #   it 'should reduce the balance on the card' do
    #     expect{ card.deduct 3 }.to change{ card.balance }.by -3
    #   end
    # end
  end

  context 'Oystercard actions' do

    describe '#touch_in' do
      # refactoring for journey class
      it 'should prevent card in journey from touching in' do
        allow(card).to receive(:in_journey?).and_return(true)
        expect{ card.touch_in(station) }.to raise_error "This card is already in journey."
      end
      it 'should raise an error if balance is below mininum amount' do
        expect { card.touch_in(station) }.to raise_error "Card balance is too low."
      end

      it 'creates a new instance of Journey' do
        card.top_up(15)
        expect(journey).to receive(:new).with(station)
        card.touch_in(station)
      end
    end

    describe '#touch_out' do
      # refactoring for journey class
      it 'should set in_journey? to false' do
        allow(card).to receive(:in_journey?).and_return(false)
        expect{ card.touch_out(station) }.to raise_error "This card is not in journey."
      end
      # NOT REFACTORED
      it 'should prevent card not in journey from touching out' do
        expect{ card.touch_out(station) }.to raise_error "This card is not in journey."
      end
      it 'should deduct card balance by minimum amount' do
        allow(card).to receive(:in_journey?).and_return(true)
        card.top_up(5)
        expect{ card.touch_out(station) }.to change{ card.balance }.by -1
      end
    end

    context 'Oystercard journeys' do
      describe 'should store journey history' do
        # it 'should return a hash' do
        #   expect(card.journeys).to be_a(Hash)
        # end
        it 'should increment journey_index by 1' do
          card.top_up(5)
          expect{ card.touch_in(station) }.to change{ card.journey_index }.by 1
        end
        it 'should add in station on touch in to journey history' do
          card.top_up(5)
          card.touch_in(station)
          expect(card.journeys).to include( 1 => { :in => station } )
        end
        it 'should add out station on touch out to journey history' do
          card.top_up(5)
          card.touch_in(station)
          card.touch_out(station2)
          expect(card.journeys).to include( 1 => { :in => station, :out => station2 } )
        end
      end
    end
  end
end
