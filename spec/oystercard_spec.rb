require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station){ double :station }
  describe "#balance" do

    it 'will begin with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'will increase the balance by the specified amount' do
      balance1 = oystercard.balance
      oystercard.top_up(5)
      balance2 = oystercard.balance
      expect(balance2 > balance1).to be true
    end

  end

  describe "#top_up" do

    it 'should raise an error if the total balance added is above 90' do
      expect{oystercard.top_up(100)}.to raise_error(RuntimeError)
    end

    it 'should raise an error if the total balance after transaction is over 90' do
      oystercard.top_up(80)
      expect{oystercard.top_up(20)}.to raise_error(RuntimeError)
    end

  end

  describe "#deduct" do

    it 'should deduct money if the journey occurs' do
      balance1 = oystercard.balance
      oystercard.deduct(5)
      balance2 = oystercard.balance
      expect(balance2 < balance1).to be true
    end

  end

  describe "#journey" do

    it 'should verify in journey' do
       expect(oystercard).not_to be_in_journey
     end

  end

  describe "#touch in" do

    it 'should confirm touch in' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
       expect(oystercard.in_journey?).to be true
    end

    it 'should update the entry station' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

    it 'should prevent journey if balance is under 1 pound' do
      expect{oystercard.touch_in(station) while true}.to raise_error(RuntimeError)
    end



 end

  describe "#touch out" do

    it 'should confirm touch out' do
      expect(oystercard.touch_out).to eq false
    end

    it 'should deduct the correct amount for journey' do
      expect { oystercard.touch_out }.to change{ oystercard.balance }.by (-1)
    end

end

end
