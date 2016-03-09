require 'byebug'
require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new "station" }
  let(:station) { double(:station) }

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

      it 'returns the start of journey record with date/time and in' do
        allow(journey).to receive(:entry_station).and_return("station")
        begin_time = Time.now.strftime("%H:%M:%S")
        expect(journey.start_journey).to include( { begin_time => { :in => "station" } } )
      end
    end

    describe '#end' do
      it 'returns the remainder of journey record' do
        begin_time = Time.now.strftime("%H:%M:%S")
        expect(journey.end_journey("station2")).to include( { begin_time => { :in => "station", :out => "station2" } } )
      end
    end

    describe '#fare' do
      it 'returns fare' do
        begin_time = Time.now.strftime("%H:%M:%S")
        expect(journey.fare).to include( { begin_time => { :in => "station", :out => "station2", :fare => 1 } } )
      end
    end
  end
end
