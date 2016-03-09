require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new}

  before do
    card.top_up(20)
  end

  describe '#balance' do
    it 'checks that new card has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'it adds 20 to balance' do
      expect(card.balance).to eq 20
    end

    it 'raises an error if balance exceeds limit' do
      message = "Error, balance exceeds £#{Oystercard::MAX_LIMIT}!"
      expect{ card.top_up(100) }.to raise_error message
    end
  end

  describe '#in_journey?' do
    it 'card not in use' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'card is in journey' do
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    it 'raises error when balance insufficient' do

      message = "Error insufficient funds"
      expect{ subject.touch_in }.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'card is not in journey' do
      card.touch_in
      card.touch_out
      expect(card.in_journey?).to eq false
    end

   it 'deducts fare from balance' do
     expect{ card.touch_out }.to change{ card.balance }.by -3
   end
  end
end
