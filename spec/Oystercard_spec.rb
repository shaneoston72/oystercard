# in spec/Oystercard_spec.rb
require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

  context 'Oystercard balance' do
    describe '#card_balance' do
      it "should show the card's initial balance" do
        new_card = card
        expect(card.balance).to eq 0
      end
    end
  end
end
