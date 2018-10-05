require 'pry'
require './card.rb'
require './hands.rb'
require './create_deck.rb'
require './shuffle_deck.rb'
require './remove_cards_from_deck.rb'

deck = create_deck
remove_cards_from_deck(deck, [Card.new(3, 's'), Card.new(5, 'd')])
shuffle_deck(deck)
