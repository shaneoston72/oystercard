require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }


  it 'will begin with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'will increase the balance by the specified amount' do
    balance1 = oystercard.balance
    oystercard.top_up(5)
    balance2 = oystercard.balance
    expect(balance2 > balance1).to be true
  end

  it 'should raise an error if the total balance added is above 90' do
    expect{oystercard.top_up(100)}.to raise_error
  end

  it 'should raise an error if the total balance after transaction is over 90' do
    oystercard.top_up(80)
    expect{oystercard.top_up(20)}.to raise_error
  end
end
