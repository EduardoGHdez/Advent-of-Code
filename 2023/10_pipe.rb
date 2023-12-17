# | is a vertical pipe connecting north and south.
# - is a horizontal pipe connecting east and west.
# L is a 90-degree bend connecting north and east.
# J is a 90-degree bend connecting north and west.
# 7 is a 90-degree bend connecting south and west.
# F is a 90-degree bend connecting south and east.
# . is ground; there is no pipe in this tile.
# S is the starting position of the animal; there is a pipe on this tile, but
#   your sketch doesn't show what shape the pipe has.
class Pipe
  class Base
    attr_accessor :x, :y, :surface, :direction

    def initialize(x:, y:, surface:, direction: nil)
      @x = x
      @y = y
      @surface = surface
      @direction = direction
    end

    def up
      surface[y.pred][x]
    end

    def down
      surface[y.next][x]
    end

    def right
      surface[y][x.next]
    end

    def left
      surface[y][x.pred]
    end

    def next_left
      return Horizontal.new(x: x.pred, y:, surface:, direction: :left) if Horizontal.matches?(left)
      return NorthEast.new(x: x.pred, y:, surface:, direction: :left) if NorthEast.matches?(left)
      return SouthEast.new(x: x.pred, y:, surface:, direction: :left) if SouthEast.matches?(left)
    end

    def next_right
      return Horizontal.new(x: x.next, y:, surface:, direction: :right) if Horizontal.matches?(right)
      return NorthWest.new(x: x.next, y:, surface:, direction: :right) if NorthWest.matches?(right)
      return SouthWest.new(x: x.next, y:, surface:, direction: :right) if SouthWest.matches?(right)
    end


    def next_up
      return Vertical.new(x:, y: y.pred, surface:, direction: :up) if Vertical.matches?(up)
      return SouthWest.new(x:, y: y.pred, surface:, direction: :up) if SouthWest.matches?(up)
      return SouthEast.new(x:, y: y.pred, surface:, direction: :up) if SouthEast.matches?(up)
    end

    def next_down
      return Vertical.new(x:, y: y.next, surface:, direction: :down) if Vertical.matches?(down)
      return NorthWest.new(x:, y: y.next, surface:, direction: :down) if NorthWest.matches?(down)
      return NorthEast.new(x:, y: y.next, surface:, direction: :down) if NorthEast.matches?(down)
    end

    def self.matches?(symbol)
      @symbol == symbol
    end

    private

    def self.symbol(symbol = nil)
      @symbol ||= symbol
    end
  end

  class Horizontal < Base
    symbol '-'

    def next
      return next_right if direction == :right
      return next_left if direction == :left
    end
  end

  class Vertical < Base
    symbol '|'

    def next
      return next_up if direction == :up
      return next_down if direction == :down
    end
  end

  class NorthWest < Base
    symbol 'J'

    def next
      return next_up if direction == :right
      return next_left if direction == :down
    end
  end

  class NorthEast < Base
    symbol 'L'

    def next
      return next_up if direction == :left
      return next_right if direction == :down
    end
  end

  class SouthWest < Base
    symbol '7'

    def next
      return next_down if direction == :right
      return next_left if direction == :up
    end
  end

  class SouthEast < Base
    symbol 'F'

    def next
      return next_down if direction == :left
      return next_right if direction == :up
    end
  end

  class S < Base
    symbol 'S'

    def next
      # Left
      return Horizontal.new(x: x.pred, y:, surface:, direction: :left) if Horizontal.matches?(left)
      return NorthEast.new(x: x.pred, y:, surface:, direction: :left) if NorthEast.matches?(left)
      return SouthEast.new(x: x.pred, y:, surface:, direction: :left) if SouthEast.matches?(left)

      # Right
      return Horizontal.new(x: x.next, y:, surface:, direction: :right) if Horizontal.matches?(right)
      return NorthWest.new(x: x.next, y:, surface:, direction: :right) if NorthWest.matches?(right)
      return SouthWest.new(x: x.next, y:, surface:, direction: :right) if SouthWest.matches?(right)


      # Up
      return Vertical.new(x:, y: y.pred, surface:, direction: :up) if Vertial.matches?(up)
      return SouthWest.new(x:, y: y.pred, surface:, direction: :up) if SouthWest.matches?(up)
      return SouthEast.new(x:, y: y.pred, surface:, direction: :up) if SouthEast.matches?(up)

      # Down
      return Vertical.new(x:, y: y.next, surface:, direction: :down) if Vertial.matches?(down)
      return NorthWest.new(x:, y: y.next, surface:, direction: :down) if NorthWest.matches?(down)
      return NorthEast.new(x:, y: y.next, surface:, direction: :down) if NorthEast.matches?(down)
    end
  end
end
