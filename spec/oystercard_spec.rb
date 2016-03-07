require 'oystercard'
describe Oystercard do 
  subject(:oystercard) { described_class.new }
 
  it { is_expected.to respond_to(:balance) }
  
  it 'will begin with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end
end

