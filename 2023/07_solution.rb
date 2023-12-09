require './07_hand'

# Example:
sample_hands = File.open('07_sample.txt', 'r').read.lines.map do |raw|
  cards, bid = raw.strip.split(' ')
  Hand.new(cards:, bid: bid.to_i)
end

sample_hands.each { |hand| p [hand.cards, hand.type] }
p "-------------------------------------"
sample_hands.sort.reverse.each { |hand| p [hand.cards, hand.type] }

solution = sample_hands.sort.reverse.each_with_index.sum do |hand, rank|
  hand.bid * (rank + 1)
end

p "Solution: #{solution}"

# Part 1 and 2
sample_hands = File.open('07_input.txt', 'r').read.lines.map do |raw|
  cards, bid = raw.strip.split(' ')
  Hand.new(cards:, bid: bid.to_i)
end

solution = sample_hands.sort.reverse.each_with_index.sum do |hand, rank|
  hand.bid * (rank + 1)
end

p "Solution: #{solution}"
