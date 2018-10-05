def remove_cards_from_deck(deck, cards)
  cards.each do |card|
    deck.delete_if { |d| card.same?(d) }
  end
end
