calibration_document = File.open('01_input.txt', 'r').read

NUMBERS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  eighthree: 8,
  nine: 9,
}

REGEX = /(?=(#{NUMBERS.keys.join('|')}|\d))/

result = calibration_document.lines.inject(0) do |total, line|
  matches = line.scan(REGEX).flatten
  first, last = matches.values_at(0, -1)
  first_digit = NUMBERS.fetch(first.to_sym, first).to_s
  second_digit = NUMBERS.fetch(last.to_sym, last).to_s

  calibration_value = (first_digit + second_digit).to_i

  puts "#{line.strip} => #{calibration_value}"
  p matches

  total + calibration_value
end

puts "Result: #{result}"
