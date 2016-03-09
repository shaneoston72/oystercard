require 'journey'
# require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new "station" }


  describe '#initialize' do
    it 'initializes the station' do
      expect(journey.entry_station).to eq "station"
    end

    it 'status of in_journey' do
      expect(journey.status).to eq :in_journey
    end
  end

  context 'Journey record' do
    describe '#begin' do
      it 'returns a hash record with date/time and in' do
        allow(journey).to receive(:entry_station).and_return("station")
        begin_time = Time.now.strftime("%H:%M:%S")
        expect(journey.begin).to include( { begin_time => { :in => "station" } } )
      end
      describe '#end' do

      end
    end
  end
end
