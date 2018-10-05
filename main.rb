require 'pry'
require './card.rb'
require './hands.rb'
require './create_deck.rb'
require './shuffle_deck.rb'

deck = create_deck
shuffle_deck(deck)
