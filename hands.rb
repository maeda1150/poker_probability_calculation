class OverFiveCardError < StandardError; end

def one_pair?(cards)
  raise OverFiveCardError if cards.size >= 6
  count = 0
  cards.combination(2) do |a, b|
    count = count + 1 if a.number == b.number
  end
  count == 1
end

def two_pair?(cards)
  raise OverFiveCardError if cards.size >= 6
  count = 0
  set   = []
  cards.combination(2) do |a, b|
    if a.number == b.number
      count = count + 1
      set << a.number
    end
  end
  count == 2 && set[0] != set[1]
end

def three_of_a_kind?(cards)
  raise OverFiveCardError if cards.size >= 6
  return false if four_of_a_kind?(cards)
  cards.combination(3) do |a, b, c|
    if a.number == b.number && b.number == c.number
      rest = cards.reject {|card| card.same?(a) || card.same?(b) || card.same?(c) }
      return true if rest[0].number != rest[1].number
    end
  end
  false
end

def straight?(cards)
  raise OverFiveCardError if cards.size >= 6
  return false if nakid_flush?(cards)
  nakid_straight?(cards)
end

def nakid_straight?(cards)
  raise OverFiveCardError if cards.size >= 6
  sorted = cards.sort {|a, b| a.number <=> b.number }
  return true if sorted.map(&:number) == [1, 10, 11, 12, 13]
  base = sorted[0].number
  sorted.each_with_index do |card, index|
    return false if card.number != (base + index)
  end
  true
end

def flush?(cards)
  raise OverFiveCardError if cards.size >= 6
  return false if nakid_straight?(cards)
  nakid_flush?(cards)
end

def nakid_flush?(cards)
  raise OverFiveCardError if cards.size >= 6
  cards[0].suit == cards[1].suit && cards[0].suit == cards[2].suit && cards[0].suit == cards[3].suit && cards[0].suit == cards[4].suit
end

def full_house?(cards)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(3) do |a, b, c|
    if a.number == b.number && b.number == c.number
      rest = cards.reject {|card| card.same?(a) || card.same?(b) || card.same?(c) }
      return true if rest[0].number == rest[1].number
    end
  end
  false
end

def four_of_a_kind?(cards)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(4) do |a, b, c, d|
    return true if a.number == b.number && b.number == c.number && c.number == d.number
  end
  false
end

def straight_flush?(cards)
  raise OverFiveCardError if cards.size >= 6
  nakid_straight?(cards) && nakid_flush?(cards)
end

# TODO: need improve
def one_pair_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  return true if !one_pair?(cards) && hands[0].number == hands[1].number
  hands.each do |hand|
    return true if cards.map(&:number).include?(hand.number)
  end
  false
end

# TODO: need improve
def two_pair_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(3) do |a, b, c|
    comb = [a, b, c, *hands]
    return true if two_pair?(comb)
  end
  false
end

# TODO: need exclude full house
def three_of_a_kind_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(3) do |a, b, c|
    next if a.number == b.number && a.number == c.number
    comb = [a, b, c, *hands]
    return true if three_of_a_kind?(comb)
  end
  false
end

def straight_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(3) do |a, b, c|
    comb = [a, b, c, *hands]
    return true if straight?(comb)
  end
  cards.combination(4) do |a, b, c, d|
    comb = [a, b, c, d, hands[0]]
    return true if straight?(comb)
  end
  cards.combination(4) do |a, b, c, d|
    comb = [a, b, c, d, hands[1]]
    return true if straight?(comb)
  end
  false
end

def flush_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  cards.combination(3) do |a, b, c|
    comb = [a, b, c, *hands]
    return true if flush?(comb)
  end
  cards.combination(4) do |a, b, c, d|
    comb = [a, b, c, d, hands[0]]
    return true if flush?(comb)
  end
  cards.combination(4) do |a, b, c, d|
    comb = [a, b, c, d, hands[1]]
    return true if flush?(comb)
  end
  false
end

def pair_with_hands?(cards, hands)
  raise OverFiveCardError if cards.size >= 6
  hands.each do |hand|
    return true if cards.map(&:number).include?(hand.number)
  end
  false
end
