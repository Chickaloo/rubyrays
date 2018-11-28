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
    for i in 0..6 do
      collision = current_ray.trace(@objects)
      if collision.exists?
        collision.set_reflection
        current_ray = Vector.new(collision.x, collision.y, collision.rx, collision.ry, Gosu::Color.new(current_ray.color.alpha*0.8,255,255,255))
        @rays.push(current_ray)
        #new_ray = Vector.new(collision.x, collision.y, collision.nx, collision.ny, Gosu::Color.new(50,255,0,0))
        #@rays.push(new_ray)
      end
    end

    collision = current_ray.trace(@objects)
    
    for r in @rays do
    end

    for o in @objects do

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
