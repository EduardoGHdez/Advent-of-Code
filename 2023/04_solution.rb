scratchcards = File.open('04_input.txt', 'r').read

# Part 1
solution = scratchcards.lines.map do |raw|
  scratchcard = raw.match(/(?<id>.+):(?<numbers>.+)/)
  winning_numbers, numbers = scratchcard[:numbers].split('|').map { |n| n.scan(/\d+/) } 
  matches = winning_numbers & numbers

  poitns = matches.any? ? 2 ** (matches.length - 1) : 0
end.sum

puts "Solution 1: #{solution}"

# Part 2
solution = scratchcards.lines.reduce({}) do |total, raw|
  scratchcard = raw.match(/(?<card>.+):(?<numbers>.+)/)
  id = scratchcard[:card].match(/(?<id>\d+)/)[:id]
  winning_numbers, numbers = scratchcard[:numbers].split('|').map { |n| n.scan(/\d+/) } 
  matches = winning_numbers & numbers

  total[id] = total[id].nil? ? 1 : total[id] + 1
  
  matches.length.times do |match|
    next_card = (id.to_i + match + 1).to_s
    add_ups = total[id]
    total[next_card] = total[next_card].nil? ? add_ups : total[next_card] + add_ups
  end

  total
end.values.sum

puts "Solution 2: #{solution}"
