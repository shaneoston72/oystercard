require 'oystercard'

describe Oystercard do
  let(:oystercard) {described_class.new}

  describe "#balance" do
    it "1.0 has a balance of £0" do
      expect( oystercard.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "2.0 tops up the balance by £20" do
      oystercard.top_up(20)
      expect(oystercard.balance).to eq 20
    end

    it '2.1 raises error if balance exceeds £90' do
      limit = Oystercard::MAX_BALANCE
      message = "Limit is £#{limit}"
      expect{oystercard.top_up(90)}.to raise_error message
    end
  end

end
