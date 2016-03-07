class Oystercard

  CARD_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Card balance may not exceed £#{CARD_LIMIT}" if amount + balance > CARD_LIMIT
    @balance += amount
  end
end
