require 'pry'
require './card.rb'
require './hands.rb'
require './create_deck.rb'
require './shuffle_deck.rb'
require './remove_cards_from_deck.rb'
require './utils.rb'

hands = [Card.new(3, 's'), Card.new(5, 'd')]

results = {
  one_pair: 0,
  two_pair: 0,
  three_of_a_kind: 0,
  straight: 0,
  flush: 0,
  full_house: 0,
  four_of_a_kind: 0,
  straight_flush: 0
}

start_time = Time.now

100_000.times do |t|
  deck = create_deck
  remove_cards_from_deck(deck, hands)
  shuffle_deck(deck)
  table = deck[0..4]
  all = table.concat(hands)

  one_pair = false
  two_pair = false
  three_of_a_kind = false
  straight = false
  flush = false
  full_house = false
  four_of_a_kind = false
  straight_flush = false

  all.combination(5) do |a, b, c, d, e|
    temp = [a, b, c, d, e]
    one_pair = true if one_pair?(temp)
    two_pair = true if two_pair?(temp)
    three_of_a_kind = true if three_of_a_kind?(temp)
    straight = true if straight?(temp)
    flush = true if flush?(temp)
    full_house = true if full_house?(temp)
    four_of_a_kind = true if four_of_a_kind?(temp)
    straight_flush = true if straight_flush?(temp)
  end

  results[:one_pair] = results[:one_pair] + 1 if one_pair
  results[:two_pair] = results[:two_pair] + 1 if two_pair
  results[:three_of_a_kind] = results[:three_of_a_kind] + 1 if three_of_a_kind
  results[:straight] = results[:straight] + 1 if straight
  results[:flush] = results[:flush] + 1 if flush
  results[:full_house] = results[:full_house] + 1 if full_house
  results[:four_of_a_kind] = results[:four_of_a_kind] + 1 if four_of_a_kind
  results[:straight_flush] = results[:straight_flush] + 1 if straight_flush
end

puts "one_pair:        #{to_percent(results[:one_pair], 100_000)} %"
puts "two_pair:        #{to_percent(results[:two_pair], 100_000)} %"
puts "three_of_a_kind: #{to_percent(results[:three_of_a_kind], 100_000)} %"
puts "straight:        #{to_percent(results[:straight], 100_000)} %"
puts "flush:           #{to_percent(results[:flush], 100_000)} %"
puts "full_house:      #{to_percent(results[:full_house], 100_000)} %"
puts "four_of_a_kind:  #{to_percent(results[:four_of_a_kind], 100_000)} %"
puts "straight_flush:  #{to_percent(results[:straight_flush], 100_000)} %"

puts '-' * 20
puts "time cost : #{cut_below_two_digits(Time.now - start_time)}s"
