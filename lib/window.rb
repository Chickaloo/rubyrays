require 'gosu'

require_relative 'collision'

class RubyRays < Gosu::Window
  def initialize
    @source = Vector.new($screen_w/2,$screen_h/2,1,1)
    @font = Gosu::Font.new(15)
    @rays = []
    @collisions = []
    @objects = [
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255)),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255)),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255)),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255)),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(8),$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))]
    super $screen_w, $screen_h
  end

  # Refactor
  def button_up(id)
    case id
    when 4  # A: Move source
      @source.set_origin(mouse_x, mouse_y)
    when 6  # C: Remove object at cursor
      $max_bounces = $max_bounces - 1
      if $max_bounces < -1
        $max_bounces = -1
      end
    when 7  # D: Remove object at cursor
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          @objects.delete(o)
        end
      end
    when 8  # E: Remove object at cursor
      $max_bounces = $max_bounces + 1
    when 30 # Spawn Circle
    when 31 # Spawn another source...?
    when 32 # Spawn Triangle
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),3,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 33 # Spawn Square
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),4,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 34 # Spawn Pentagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),5,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 35 # Spawn Hexagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),6,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 36 # Spawn Septagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),7,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 37 # Spawn Octagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),8,$rng.rand(360),Gosu::Color.new(255,$rng.rand(0..1)*255,$rng.rand(0..1)*255,$rng.rand(0..1)*255))
      )
    when 38 # Spawn Nonagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),30,180,Gosu::Color::YELLOW)
      )
    when 39 # Spawn Circle
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(50..160),30,0,Gosu::Color::CYAN)
      )
    end
  end

  def button_down(id)
    case id
    when 45 # -: Shrink Object
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(-5, 0 , 0, 0)
        end
      end
    when 46 # +: Grow Object
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(5, 0 , 0, 0)
        end
      end
    when 47 # [: Rotate Object CCW (Left)
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, -Math::PI/16 , 0, 0)
        end
      end
    when 48 # ]: Rotate Object CW (Right)
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, Math::PI/16, 0, 0)
        end
      end
    when 79 # R: Nudge Right
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, 0 , 5, 0)
        end
      end
    when 80 # L: Nudge Left
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, 0, -5, 0)
        end
      end
    when 81 # D: Nudge Down
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, 0 , 0, 5)
        end
      end
    when 82 # U: Nudge Up
      for o in @objects do
        if o.contains?(self.mouse_x, self.mouse_y)
          o.alter(0, 0 , 0, -5)
        end
      end
    end
  end

  # needs_cursor? toggles system pointer on
  def needs_cursor?
    return true
  end

  def update
    @source.set_direction(self.mouse_x, self.mouse_y)
    current_ray = @source
    # Trace the ray
    for i in 0..$max_bounces do
      collision = current_ray.trace(@objects)
      if collision.exists?
        collision.set_reflection
        r = current_ray.color.red * (collision.color.red.to_f/255)
        g = current_ray.color.green * (collision.color.green.to_f/255)
        b = current_ray.color.blue * (collision.color.blue.to_f/255)
        current_ray = Vector.new(collision.x, collision.y, collision.rx, collision.ry, Gosu::Color.new(current_ray.color.alpha*0.9,r,g,b))
        @rays.push(current_ray)
        #new_ray = Vector.new(collision.x, collision.y, collision.nx, collision.ny, Gosu::Color.new(50,255,0,0))
        #@rays.push(new_ray)
      end
    end

    # Trace it one last time to set the endpoint (if applicable)
    collision = current_ray.trace(@objects)

    # BRDF code goes here
    #for r in @rays do
    #end
  end

  def draw
    @source.draw
    for r in @rays do
      r.draw
    end
    # Clear rays for next wave
    @rays = []
    for o in @objects do
      o.draw
    end
    # Reference Line for debugging
    #Gosu.draw_line(@source.x, @source.y, Gosu::Color::RED, self.mouse_x, self.mouse_y, Gosu::Color::RED, 50)
  end

end
