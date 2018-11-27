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

require_relative 'vector'
require_relative 'worldobject'

$screen_w = 640
$screen_h = 480
$rng = Random.new
$line_max = Math.sqrt($screen_w*$screen_w + $screen_h*$screen_h)

class RubyRays < Gosu::Window
  def initialize
    @source = Vector.new($screen_w/2,$screen_h/2,1,1)
    @rays = []
    @objects = [
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(15),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..160),$rng.rand(15),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(15),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(15),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255))),
      WorldObject.new($rng.rand($screen_w),$rng.rand($screen_h),$rng.rand(50..80),$rng.rand(15),$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))]
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
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(160),9,$rng.rand(360),Gosu::Color.new(255,$rng.rand(255),$rng.rand(255),$rng.rand(255)))
      )
    when 39 # Spawn Nonagon
      @objects.push(
        WorldObject.new(self.mouse_x,self.mouse_y,$rng.rand(160),9,$rng.rand(360))
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
    #@source.trace
    #self.caption = self.mouse_x.to_s + " " + self.mouse_y.to_s
    for r in @rays do
      r.set_direction(self.mouse_x, self.mouse_y)
    end
  end

  def draw
    @source.draw
    for r in @rays do
      r.draw
    end
    for o in @objects do
      o.draw
    end
    # Reference Line for debugging
    Gosu.draw_line(0, 0, Gosu::Color.argb(0xff_800000), self.mouse_x, self.mouse_y, Gosu::Color.argb(0xff_800000), 50)
  end

end

RubyRays.new.show
