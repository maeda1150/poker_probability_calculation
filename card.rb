class Card
  class CardInvalidError < StandardError; end

  attr_reader :number, :suit

  def initialize(number, suit)
    @number = number.to_i
    @suit   = suit
    check_number
    check_suit
  end

  def same?(card)
    number == card.number && suit == card.suit
  end

  def show
    puts number.to_s + suit
  end

  private

  def check_number
    raise CardInvalidError unless [*(1..13)].include?(number)
  end

  def check_suit
    raise CardInvalidError unless %w[s h d c].include?(suit)
  end
end
