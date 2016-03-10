require 'station'
describe Station do

  subject { described_class.new("name", 1) }

  context 'initialization of class Station' do
    describe '#initialize' do
      it 'exposed the station name' do
        expect(subject.name).to eq "name"
      end
      it 'exposed the station zone' do
        expect(subject.zone).to eq 1
      end
    end
  end
end
