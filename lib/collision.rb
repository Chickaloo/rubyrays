require 'gosu'

class Collision
  def initialize(hit_x = -999, hit_y = -999, norm_x = -999, norm_y = -999, in_x = -999, in_y = -999, col = Gosu::Color::WHITE)
    @x = hit_x
    @y = hit_y
    @nx = norm_x
    @ny = norm_y
    @ix = in_x
    @iy = in_y
    @rx = 0
    @ry = 0
    @color = col # Replace with Material
  end

  attr_reader :x
  attr_reader :y
  attr_reader :nx # Normal X slope
  attr_reader :ny # Normal Y slope
  attr_reader :rx # Reflected X slope
  attr_reader :ry # Reflected Y slope
  attr_reader :color # Material color, replace with material

  # exists returns if there is a valid collision or not.
  # Refactor to something not... something not so... quaint (bad).
  def exists?
    return @x != -999
  end

  # Set reflection calculates the reflection and some other parameters for the ray.
  # This is done seperately to
  def set_reflection
    # Reverse incoming slope to ensure correct answer
    dln = Math.sqrt(@ix**2 + @iy**2)
    dx = -@ix/dln
    dy = -@iy/dln

    # Normalize n vector so that we can find a point along the norm
    ln = Math.sqrt(@nx**2 + @ny**2)
    @nx = @nx/ln
    @ny = @ny/ln

    # shift the collision up along the norm a tiny bit to prevent penetration
    @x = @x + 0.1*@nx
    @y = @y + 0.1*@ny

    # r = d - 2*(d.n)*n : Reflected line
    dot_product = (dx*@nx + dy*@ny)
    @rx = -(dx - 2*dot_product*@nx)
    @ry = -(dy - 2*dot_product*@ny)

  #  @log = sprintf("Collision Log\nCollision x: %.2f \t y: %.2f\nSlopes norm: %.4f \t entry: %.4f \t test: %.4f\nIntercepts norm: %.4f \t entry: %.4f \t test: %.4f\nResults x: %.2f \t y: %.2f\na: %.4f \t o: %.4f \t h: %.4f\ntheta: %.2f\tphi: %.2f\nExit slope x: %.4f \t y: %.4f\nresult ln m: %.4f \t b: %.4f", @x, @y, @ny/@nx, dy/dx, -@nx/@ny, bm, b2, b1, int_x, int_y, a, o, @h, @t*180/Math::PI, @p*180/Math::PI, @rx, @ry, rm, rb)
  end
end
