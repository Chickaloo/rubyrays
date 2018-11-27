require 'gosu'

class WorldObject
  def initialize(ctr_x = 0, ctr_y = 0, rad = 20, s = 3, rot = 0, c = Gosu::Color.argb(0xff_808080))
    @center_x = ctr_x
    @center_y = ctr_y
    @radius = rad
    if s < 3
      s = 3
    end
    @sides = s
    @rotation = rot
    @points_x = []
    @points_y = []
    @color = c

    for i in 0..@sides do
      o = @rotation + (i*(2*Math::PI/@sides))
      @points_x.push(@center_x.to_i + (@radius.to_i * Math.cos(o)))
      @points_y.push(@center_y.to_i + (@radius.to_i * Math.sin(o)))
    end
  end

  def contains?(mx, my)
    dx = mx-@center_x
    dy = my-@center_y
    dist = Math.sqrt(dx*dx + dy*dy)
    if dist < @radius
      return true
    else
      return false
    end
  end

  def intersection?(ox, oy, dx, dy)

    return true
  end

  def draw
    for i in 0..@sides do
      sx = @points_x[i]
      sy = @points_y[i]
      ex = @points_x[(i+1)%@sides]
      ey = @points_y[(i+1)%@sides]

      Gosu.draw_line(sx, sy, @color, ex, ey, @color, 50)
    end
  end

end
