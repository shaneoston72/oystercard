require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }


  it {is_expected.to respond_to(:top_up).with(1).argument}

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
