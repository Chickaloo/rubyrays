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

require 'ruby2d'

require_relative 'lib/config'
require_relative 'lib/debug'
require_relative 'lib/controls'

$tick = 0
$debug = true
#d = Debug.new
line = Line.new(
  x1: 0, y1: 0,
  x2: 0, y2: 0,
  width: 5,
  color: [1, 1, 1, 1],
  z: 100
)

update do
  # set background: [Math.sin(tick.to_f/100%1), Math.sin(tick.to_f/100%1), Math.sin(tick.to_f/100%1), 1]
  if $debug
    $texts[0].text = 'FPS: ' + get(:fps).to_s
    if get(:fps).to_i > 50
      $texts[0].color = 'green'
    else
      $texts[0].color = 'red'
    end

    mx = get(:mouse_x).to_s
    my = get(:mouse_y).to_s

    $texts[1].text = 'Mouse: ' + mx + ' ' + my
  end

  line.x2 = get(:mouse_x)
  line.y2 = get(:mouse_y)

  $tick += 1
end

show
