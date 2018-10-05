def shuffle_deck(deck)
  [*(10..20)].sample.times do |i|
    deck.shuffle!
    deck.rotate!(i)
    deck.reverse!
  end
end
