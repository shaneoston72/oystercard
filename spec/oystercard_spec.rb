require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new}

  describe '#balance' do
    it 'checks that new card has a balance' do
      expect(card.balance).to eq 0
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
      #it { is_expected.to respond_to(:top_up).with(1).argument}

  end

  describe '#deduct' do
    it 'deducts 3 from balance' do
      card.top_up(10)
      card.deduct(3)
      expect(card.balance).to eq 7
    end
  end

  describe '#in_journey?' do
    it 'card not in use' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'card is in journey' do
      card.touch_in
      expect(card.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'card is not in journey' do
      card.touch_out
      expect(card.in_journey?).to eq false
    end
  end

end
