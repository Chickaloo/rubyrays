require 'gosu'

# WorldObject represents a spawnable, collidible object.
# Originally, it was intended for inheritance, but that's a todo now.
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
    @color = c
    if @color.red == 0 && @color.green == 0 && @color.blue == 0
      @color = Gosu::Color::WHITE
    end

    @points_x = []
    @points_y = []

    for i in 0..@sides do
      o = @rotation + (i*(2*Math::PI/@sides))
      @points_x.push(@center_x.to_i + (@radius.to_i * Math.cos(o)))
      @points_y.push(@center_y.to_i + (@radius.to_i * Math.sin(o)))
    end
  end

  attr_reader :center_x
  attr_reader :center_y
  attr_reader :color

  # Alter changes the parameters of the object and refreshes the points.
  def alter(size = 0, rot = 0, pos_x = 0, pos_y = 0)
    @radius = @radius + size
    @center_x = @center_x + pos_x
    @center_y = @center_y + pos_y
    @rotation = @rotation + rot


    @points_x = []
    @points_y = []

    for i in 0..@sides do
      o = @rotation + (i*(2*Math::PI/@sides))
      @points_x.push(@center_x.to_i + (@radius.to_i * Math.cos(o)))
      @points_y.push(@center_y.to_i + (@radius.to_i * Math.sin(o)))
    end
  end

  # contains? returns true or false depending on if the point is within self
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

  # get_intersections returns a list of Collision objects.
  def get_intersections(m1, b1, dx, dy)

    intersections = []

    # check
    for i in 0..@sides do
      sx = @points_x[i]
      sy = @points_y[i]
      ex = @points_x[(i+1)%@sides]
      ey = @points_y[(i+1)%@sides]
      len = Math.sqrt((ex-sx)**2 + (ey-sy)**2)
      m2 = (ey-sy)/(ex-sx)
      b2 = sy-(m2*sx)

      # If collision is possible
      if !(m2 == m1 || m2 == -m1)
        ix = (b2-b1) / (-m2+m1)
        iy = b1 + (m1*ix)
        dist_s = Math.sqrt((ix-sx)**2 + (iy-sy)**2)
        dist_e = Math.sqrt((ix-ex)**2 + (iy-ey)**2)
        if !(dist_s > len) && !(dist_e > len)

          # calculate normal
          ay = (ey-sy)
          ax = (ex-sx)
          div = ay
          if ax > ay
            div = ax
          end
          nx = ay/div
          ny = -ax/div

          # Flip normal for special case

          if ey < sy && ex < sx
            nx = -nx
            ny = -ny
          end

          # calculate direction

          intersections.push(Collision.new(ix, iy, nx, ny, dx, dy, @color))
        end
        # a polygon has a maximum of two intersections. Save some time by skipping
        if intersections.length == 2
          break
        end
      end
    end

    return intersections
  end

  def draw
    for i in 0..@sides-1 do
      sx = @points_x[i]
      sy = @points_y[i]
      ex = @points_x[(i+1)%@sides]
      ey = @points_y[(i+1)%@sides]

      #m2 = (ey-sy)/(ex-sx)
      #b2 = sy-(m2*sx)
      Gosu.draw_line(sx, sy, @color, ex, ey, @color, 50)
      #Gosu.draw_line(sx, sy, @color, 0, b2, @color, 50) Slope line debugging
    end
  end

end
