require 'gosu'

class Vector
  def initialize(nx, ny, xdir, ydir)
    @x = nx
    @y = ny
    @dx = xdir
    @dy = ydir
    @ex = 0
    @ey = 0
    @color = Gosu::Color.new(255, 255, 255, 255)
  end

  def set_origin(nx, ny)
    @x = nx
    @y = ny
  end

  def set_direction(mx, my)
    # puts mx.to_s + " " + my.to_s
    len = Math.sqrt(@dy*@dy + @dx*@dx)/$line_max

    @ex = @x + (@dx/len)
    @ey = @y + (@dy/len)
    @dx = (mx-@x)
    @dy = (my-@y)
  end

  def draw
    Gosu.draw_line(@x, @y, @color, @ex, @ey, @color)
  end

  def trace(objects)
    for obj in objects do

    end
    len = Math.sqrt(@dy*@dy + @dx*@dx)/$line_max

    @ex = @x + (@dx/len)
    @ey = @y + (@dy/len)
  end
end
