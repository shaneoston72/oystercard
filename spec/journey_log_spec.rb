require 'byebug'
require 'journey_log'

describe JourneyLog do

	let(:journey) {double :journey,  start_journey: nil }
	let(:station) {double :station }
	let(:station2) {double :station2}
	let(:journey_class) { double(:journey_class, new: journey) }
	subject(:journeylog) {described_class.new(journey_class)}

	describe '#initialize' do

		it 'has an empty array' do
			expect(journeylog.journey_history).to be_empty
		end

	end

	context 'start journey' do

		describe '#start' do
			it 'creates a new journey and records it in journey_history' do
				expect{journeylog.start(station)}.to change{journeylog.journey_history.length}.by 1
			end

			it 'calls start_journey' do
				allow(journey).to receive(:start_journey)
				expect(journey).to receive(:start_journey).with(station)
				journeylog.start(station)
			end
		end

	end

	context 'end journey' do
		describe '#finish' do
			it 'calls end_journey' do
				allow(journey).to receive(:start_journey)
				allow(journey).to receive(:exit_station)
				journeylog.start(station)
				expect(journey).to receive(:end_journey).with(station)
				journeylog.finish(station)
			end

			it 'creates a new journey when we have touched out but not touched in' do
				allow(journey).to receive(:end_journey)
				expect{journeylog.finish(station)}.to change{journeylog.journey_history.length}.by 1
			end
		end

	end

end
