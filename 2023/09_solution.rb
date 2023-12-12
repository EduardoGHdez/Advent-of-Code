# Sample
history = "0 3 6 9 12 15".split(' ').map(&:to_i)

Extrapolate = Proc.new do |history|
  steps = [history]

  loop do
    steps << steps.last.map.each_cons(2).map do |previous, current|
      current - previous
    end

    break if steps.last.all? { |step| step == 0 }
  end

  steps.reverse.each_cons(2) do |previous, step|
    step << previous.last.to_i + step.last.to_i
  end

  pp steps

  history.last
end

p Extrapolate.call(history)

# Part 1.
report = File.open('09_input.txt', 'r').read

solution = report.lines.map do |raw|
  history = raw.strip.split(' ').map(&:to_i)
  Extrapolate.call(history)
end

puts "Solution #{solution.sum}"

# Part 2
ExtrapolateBackwards = Proc.new do |history|
  steps = [history]

  loop do
    steps << steps.last.map.each_cons(2).map do |previous, current|
      current - previous
    end

    break if steps.last.all? { |step| step == 0 }
  end

  steps.reverse.each_cons(2) do |previous, step|
    step.unshift(
      step.first.to_i - previous.first.to_i
    )
  end

  pp steps

  history.first
end

solution = report.lines.map do |raw|
  puts raw
  history = raw.strip.split(' ').map(&:to_i)
  ExtrapolateBackwards.call(history)
end

puts "Solution #{solution.sum}"
