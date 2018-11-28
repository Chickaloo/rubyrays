require 'gosu'

require_relative 'collision'

class RubyRays < Gosu::Window
  def initialize
    @source = Vector.new($screen_w/2,$screen_h/2,1,1)
    @font = Gosu::Font.new(15)
    @rays = []
    @collisions = []
    @objects = [
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))]
    super $screen_w, $screen_h
  end

  def button_up(id)
    case id
    when 4  # A: Move source
      @source.set_origin(mouse_x, mouse_y)
    when 7  # D: Remove object at cursor
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          @objects.delete(o)
        end
      end
    when 30 # Spawn Circle
    when 31 # Spawn another source...?
    when 32 # Spawn Triangle
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),3,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 33 # Spawn Square
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),4,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 34 # Spawn Pentagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),5,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 35 # Spawn Hexagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),6,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 36 # Spawn Septagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),7,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 37 # Spawn Octagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),8,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 38 # Spawn Nonagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(160),30,180,Gosu::Color::YELLOW)
      )
    when 39 # Spawn Nonagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(160),30,0,Gosu::Color::CYAN)
      )
    when 45 # -: Shrink Object
    when 46 # +: Grow Object
    when 47 # [: Rotate Object CCW (Left)
    when 48 # ]: Rotate Object CW (Right)
    when 79 # R: Nudge Right
    when 80 # L: Nudge Left
    when 81 # D: Nudge Down
    when 82 # U: Nudge Up

    end

  end

  def needs_cursor?
    return true
  end

  def update
    @source.set_direction(self.mouse_x, self.mouse_y)
    current_ray = @source
    # Specular reflection: bounce 8 times
    for i in 0..8 do
      collision = current_ray.trace(@objects)
      if collision.exists?
        collision.set_reflection
        @collisions.push(collision)
        current_ray = Vector.new(collision.x, collision.y, collision.rx, collision.ry, Gosu::Color.new(255,255,255,255))
        @rays.push(current_ray)
        #current_ray = Vector.new(collision.x, collision.y, collision.rx, collision.ry, Gosu::Color.new(100,0,255,0))
        #@rays.push(current_ray)
        #new_ray = Vector.new(collision.x, collision.y, collision.nx, collision.ny, Gosu::Color.new(100,255,0,0))
        #@rays.push(new_ray)
      end
    end
    #@source.trace
    #self.caption = self.mouse_x.to_s + " " + self.mouse_y.to_s
    for r in @rays do
      #r.set_direction(self.mouse_x, self.mouse_y)
    end

    for o in @objects do

      # Debug -
      # If intersection of object and mouse at 90 degrees is less than
      # object radius away, draw a green line

      #      s_o_x = @source.x - o.center_x
      #      s_o_y = @source.y - o.center_y
      #      div = s_o_y
      #      if s_o_x > s_o_y
      #        div = s_o_x
      #      end
      #      mx = 50*s_o_y/div
      #      my = 50*s_o_x/div
      #      m = s_o_x/s_o_y
      #      b = o.center_y + m*o.center_x
      #Gosu.draw_line(o.center_x, o.center_y, Gosu::Color::RED, o.center_x+mx, o.center_y-my, Gosu::Color::GREEN, 50)
      #Gosu.draw_line(o.center_x, o.center_y, Gosu::Color::RED, 0, b, Gosu::Color::RED, 50)
    end
  end

  def draw
    @source.draw
    for r in @rays do
      r.draw
    end
    @rays = []
    for o in @objects do
      o.draw
    end
    # Reference Line for debugging
    #Gosu.draw_line(@source.x, @source.y, Gosu::Color::RED, self.mouse_x, self.mouse_y, Gosu::Color::RED, 50)
  end

end
