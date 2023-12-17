require './10_pipe'

# Part 1
surface = File.open('10_input.txt', 'r').read.lines.map(&:strip)

y = surface.find_index { |row| row.match?('S') }
x = surface[y].index('S')

pipe = Pipe::S.new(x:, y:, surface:)

pipes = loop.reduce([pipe]) do |steps|
  pipe = pipe.next

  break steps if pipe.nil?

  steps << pipe
end

puts "Solution #{ pipes.size / 2 }"

# Part 2
# See: https://en.wikipedia.org/wiki/Shoelace_formula
module Shoelace
  class << self
    def area(vertices)
      return nil if vertices.length < 3

      vertices << vertices[0]

      threading_shoelaces = (vertices.length - 1).times.map do |index|
        (vertices[index][0] * vertices[index + 1][1]) - (vertices[index + 1][0] * vertices[index][1])
      end

      (threading_shoelaces.sum.abs) / 2
    end
  end
end

vertices = [pipes.first, *(pipes.drop(1).reverse)].map { |pipe| [pipe.x, pipe.y] }
area = Shoelace.area(vertices)

# Pick's theorme
# A = i + (b / 2) - 1
# A => Area
# i => interior points
# b => boundary points
# See: https://en.wikipedia.org/wiki/Pick%27s_theorem

interior = area - (pipes.length / 2) + 1

puts "Solution #{interior}"
