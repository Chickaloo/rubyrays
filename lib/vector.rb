require 'ruby2d'

class Vector
  @rays = []
  def initialize(sx, sy, dx, dy)
    @origin_x = sx
    @origin_y = sy
    @direction_x = dx
    @dir_y = dy
    @line = Line.new()
  end

  def draw()

  end

end
