require 'oystercard'


describe Station do
let(:station) {described_class.new("Shoreditch", 1)}


describe '#name' do
  it "1.0 returns the station name" do
    expect(station.name).to eq "Shoreditch"
  end
end

describe '#zone' do
  it "2.0 returns the station zone" do
    expect(station.zone).to eq 1
  end
end

end
