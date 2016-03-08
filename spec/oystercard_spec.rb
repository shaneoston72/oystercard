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
  end

end
