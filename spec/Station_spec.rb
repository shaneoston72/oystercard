require 'station'

describe Station do

  subject(:station) { described_class.new("test",1) }

  it "provides a station's name" do
    expect(station.name).to eq "test"
  end

  it "provides a station's zone" do
    expect(station.zone).to eq 1
  end
end
