# in spec/Oystercard_spec.rb
require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

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

      it 'should reduce the balance on the card' do
        expect{ card.deduct 3 }.to change{ card.balance }.by -3
      end
    end
  end
end
