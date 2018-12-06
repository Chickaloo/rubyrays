require 'gosu'

require_relative 'collision'

class Vector
  def initialize(nx, ny, xdir, ydir, c = Gosu::Color.new(255, 255, 255, 255))
    @x = nx
    @y = ny
    @dx = xdir
    @dy = ydir
    @m = @dy.to_f/@dx
    @b = @y-(@m*@x)
    @ex = -999
    @ey = -999
    @color = c
  end

  attr_reader :x
  attr_reader :y
  attr_reader :dx
  attr_reader :dy
  attr_reader :color

  # set_origin changes the source position
  def set_origin(nx, ny)
    @x = nx
    @y = ny
    @m = @dy/@dx
    @b = @y-(@m*@x)
  end

  # set_direction adjusts the slope
  def set_direction(mx, my)
    @dx = (mx-@x)
    @dy = (my-@y)
    @m = @dy/@dx
    @b = @y-(@m*@x)
  end

  def draw
    # If endpoint hasn't been set by trace (e.g. no collision detected),
    # draw a line to "infinity"
    if @ex == -999
      len = Math.sqrt(@dy*@dy + @dx*@dx)/$line_max
      @ex = @x + (@dx/len)
      @ey = @y + (@dy/len)
    end
    #Gosu.draw_line(@x, @y, @color, @ex, @ey, Gosu::Color.new(@color.alpha*0.9,@color.red, @color.green, @color.blue))
    ddm = Math.sqrt(@dy**2 + @dx**2)
    draw_x_dir = (-@dy/ddm)*$line_thickness
    draw_y_dir = (@dx/ddm)*$line_thickness
    Gosu.draw_quad(@x+draw_x_dir, @y+draw_y_dir, @color, @ex+draw_x_dir, @ey+draw_y_dir, Gosu::Color.new(@color.alpha*0.9,@color.red, @color.green, @color.blue), @x-draw_x_dir, @y-draw_y_dir, @color, @ex-draw_x_dir, @ey-draw_y_dir, Gosu::Color.new(@color.alpha*0.9,@color.red, @color.green, @color.blue))

    # Reset endpoint
    @ex = -999
    @ey = -999
  end

  # Follow a ray and return it's collision point, given a list of all objects in
  # the scene. Also, sets endpoint to nearest collision.
  def trace(objects)

    # Find all collisions
    collisions = []
    for obj in objects do
      # TODO: Refactor
      obj_col = obj.get_intersections(@m, @b, @dx, @dy)
      for col in obj_col do
        collisions.push(col)
      end
    end

    # Return the shortest (first) collision in our path
    if collisions.length == 0
      return Collision.new
    else
      shortest_len = 9999
      shortest_i = collisions.length;
      for i in 0..(collisions.length-1) do

        cx = collisions[i].x
        cy = collisions[i].y

        # If we can reasonably expect the object to be in front of us, check it
        if (@dx <= 0 && cx < @x || @dx >= 0 && cx > @x) && (@dy <= 0 && cy < @y || @dy >= 0 && cy > @y)

          xx = collisions[i].x-@x
          yy = collisions[i].y-@y
          len = Math.sqrt(xx**2 + yy**2)
          if len < shortest_len
            shortest_len = len
            shortest_i = i
          end
        end
      end

      # If no legal collision was found, report null
      if shortest_i == collisions.length
        return Collision.new
      end

      # Otherwise, set our endpoint to the shortest collision, and return the hit
      hit = collisions[shortest_i]
      @ex = hit.x
      @ey = hit.y
      return hit
    end
  end
end
