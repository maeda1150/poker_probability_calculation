def create_deck
  deck = []
  %w[s h d c].each do |suit|
    (1..13).each do |num|
      deck << Card.new(num,  suit)
    end
  end
  deck
end
