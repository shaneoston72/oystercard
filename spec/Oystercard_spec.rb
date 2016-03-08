# in spec/Oystercard_spec.rb
require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }
  let(:station) { double(:station)}
  let(:station2) { double(:station)}

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
      it 'should set in_journey? to true' do
        card.top_up(5)
        card.touch_in(station)
        expect(card.instance_variable_get(:@entry_station)).to be_truthy
      end
      it 'should set the entry station after touch in' do
        card.top_up(5)
        card.touch_in(station)
        expect(card.entry_station).to eq station
      end

      it 'should prevent card in journey from touching in' do
        card.top_up(5)
        card.touch_in(station)
        expect{ card.touch_in(station) }.to raise_error "This card is already in journey."
      end
      it 'should raise an error if balance is below mininum amount' do
        expect { card.touch_in(station) }.to raise_error "Card balance is too low."
      end
    end

    describe '#touch_out' do
      it 'should set in_journey? to false' do
        card.top_up(5)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.instance_variable_get(:@entry_station)).to be_falsey
      end
      it 'should prevent card not in journey from touching out' do
        expect{ card.touch_out(station) }.to raise_error "This card is not in journey."
      end
      it 'should deduct card balance by minimum amount' do
        card.top_up(5)
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.balance }.by -1
      end
      it 'set entry station to nil' do
        card.top_up(5)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.entry_station).to eq nil
      end
    end

    context 'Oystercard journeys' do
      describe 'should store journey history' do
        it 'should return a hash' do
          expect(card.journeys).to be_a(Hash)
        end
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
