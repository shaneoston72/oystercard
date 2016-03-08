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
    end

    # describe "#deduct" do
    #   it 'should reduce the balance on the card' do
    #     expect{ card.deduct 3 }.to change{ card.balance }.by -3
    #   end
    # end
  end

  context 'Oystercard journey' do
    # before do
    #   card.top_up(5)
    # end

    describe '#touch_in' do
      it 'should set in_journey to true' do
        card.top_up(5)
        card.touch_in
        expect(card.instance_variable_get(:@in_journey)).to eq true
      end
      it 'should prevent card in journey from touching in' do
        card.top_up(5)
        card.touch_in
        expect{ card.touch_in }.to raise_error "This card is already in journey."
      end
      it 'shoud raise an error if balance is below mininum amount' do
        expect { card.touch_in }.to raise_error "Card balance is too low."
      end
    end

    describe '#touch_out' do
      it 'should set in_journey to false' do
        card.top_up(5)
        card.touch_in
        card.touch_out
        expect(card.instance_variable_get(:@in_journey)).to eq false
      end
      it 'should prevent card not in journey from touching out' do
        expect{ card.touch_out }.to raise_error "This card is not in journey."
      end
      it 'should deduct card balance by minimum amount' do
        card.top_up(5)
        card.touch_in
        expect{ card.touch_out }.to change{ card.balance }.by -1
      end
    end
  end

end
