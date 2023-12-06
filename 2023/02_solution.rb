games = File.open('02_input.txt', 'r').read

CUBES = { red: 12, green: 13, blue: 14 }
CUBES_REGEX = /((?<red>\d+) red|(?<green>\d+) green|(?<blue>\d+) blue)/

# Part 1
solution = games.lines.map do |raw|
  game = raw.match(/Game (?<id>\d+): (?<sets>.+)/)
  possible = game[:sets].scan(CUBES_REGEX).all? do |set|
    red, green, blue = set.map(&:to_i)

    red <= CUBES[:red] && green <= CUBES[:green] && blue <= CUBES[:blue]
  end

  possible ? game[:id].to_i : 0
end.sum

p "Solution 1: #{solution}"

# Part 2
solution = games.lines.map do |raw|
  game = raw.match(/Game (?<id>\d+): (?<sets>.+)/)
  required = game[:sets].scan(CUBES_REGEX).reduce({}) do |result, set|
    red, green, blue = set.map(&:to_i)

    {
      red: [result[:red].to_i, red].max,
      green: [result[:green].to_i, green].max,
      blue: [result[:blue].to_i, blue].max,
    }
  end

  required.values.reduce(:*)
end.sum

p "Solution 2: #{solution}"
