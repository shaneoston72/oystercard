require 'oystercard'

describe Oystercard do
  let(:oystercard) {described_class.new}
  let(:station) {double :station}
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
      expect{oystercard.top_up(91)}.to raise_error message
    end
  end

  describe '#deduct' do
    it '3.0 reduce balance by £2' do
      oystercard.top_up(20)
      oystercard.tap_out(station)
      expect(oystercard.balance).to eq 18
    end
  end

  describe '#in_journey?' do
    it '4.0 is not in journey until tapped in' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#tap_in' do
    it '5.0 is in journey' do
      oystercard.top_up(20)
      oystercard.tap_in(station)
      expect(oystercard).to be_in_journey
    end

    it '5.1 if balance < 1 ERROR - INSUFFICIENT FUNDS' do
      minimum = Oystercard::MIN_BALANCE
      message = "Balance less than £#{minimum} - NO ENTRY"
      expect{oystercard.tap_in(station)}.to raise_error message
    end

    it '5.2 stores entry station' do
      oystercard.top_up(20)
      oystercard.tap_in("Shoreditch")
      expect(oystercard.entry_station).to eq "Shoreditch"
    end
  end

  describe '#tap_out' do
    it '6.0 is not in journey' do
      oystercard.top_up(20)
      oystercard.tap_in(station)
      oystercard.tap_out(station)
      expect(oystercard).not_to be_in_journey
    end

    it '6.1 deducts minimum fare from balance' do
      oystercard.top_up(20)
      oystercard.tap_in(station)
      expect{oystercard.tap_out(station)}.to change{oystercard.balance}.by(-2)
    end

    it '6.2 tap out sets entry station to nil' do
      oystercard.top_up(20)
      oystercard.tap_in("Shoreditch")
      oystercard.tap_out(station)
      expect(oystercard.entry_station).to eq nil
    end

    it '6.3 stores exit station' do
      oystercard.top_up(20)
      oystercard.tap_in("Shoreditch")
      oystercard.tap_out("Hoxton")
      expect(oystercard.exit_station).to eq "Hoxton"
    end
  end

  describe '#journey_history' do
    it '7.0 is an empty history' do
    expect(oystercard.journey_history.size).to eq 0
    end

    it '7.1 history stores journey date, stations and fare' do
      oystercard.top_up(20)
      oystercard.tap_in("Shoreditch")
      oystercard.tap_out("Hoxton")
      expect(oystercard.journey_history).to eq "8/3/2016"=>["Shoreditch", "Hoxton"]
    end
  end

end
