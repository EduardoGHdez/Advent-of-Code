# Input
# Time:        56     97     77     93
# Distance:   499   2210   1097   1440

races = [
  { time: 56, distance: 499 },
  { time: 97, distance: 2210 },
  { time: 77, distance:  1097 },
  { time: 93, distance: 1440 }
]

# Part 1
solution = races.map.each do |race|
  time, distance = race.values

  (0..time).find_all { |speed| (speed * (time - speed)) > distance }.size
end

pp solution.reduce(:*)

# Part 2
time = 56_977_793
distance = 499_221_010_971_440
solution = (0..time).find_all { |speed| (speed * (time - speed)) > distance }.size
pp solution
