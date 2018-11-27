#! /usr/bin/ruby

=begin
Authors - Christopher Kong, Wilson Thai, Sabrina
Professor Amar Raheja
CS4080 - Programming Languages

Simple 2D Ray Tracing simulation written in Ruby.
Leverages Ruby's high degree of objectification to
make programming an otherwise complicated process
much, much faster and easier.
=end

require 'gosu'

$screen_w = 640
$screen_h = 480
$line_max = Math.sqrt($screen_w*$screen_w + $screen_h*$screen_h)

class Vector
  def initialize(nx, ny, xdir, ydir)
    @x = nx
    @y = ny
    @dx = xdir
    @dy = ydir
    @color = Gosu::Color.argb(0xff_808080)
  end

  def set_origin(nx, ny)
    @x = nx
    @y = ny
  end

  def set_direction(mx, my)
    # puts mx.to_s + " " + my.to_s
    @dx = (mx-@x)
    @dy = (my-@y)
   end

  def draw
    len = Math.sqrt(@dy*@dy + @dx*@dx)/$line_max

    end_x = @x + (@dx/len)
    end_y = @y + (@dy/len)
    Gosu.draw_line(@x, @y, @color, end_x, end_y, @color)
  end
end

class RubyRays < Gosu::Window
  def initialize
    @rays = [Vector.new(50,50,1,1)]
    super 640, 480

  end

  def needs_cursor?
    return true
  end

  def update
    self.caption = self.mouse_x.to_s + " " + self.mouse_y.to_s
    for r in @rays do
      r.set_direction(self.mouse_x, self.mouse_y)
    end
  end

  def draw
    for r in @rays do
      r.draw
    end
    Gosu.draw_line(0, 0, Gosu::Color.argb(0xff_800000), self.mouse_x, self.mouse_y, Gosu::Color.argb(0xff_800000))
  end

end

RubyRays.new.show
