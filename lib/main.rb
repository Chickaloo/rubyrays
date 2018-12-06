#! /usr/bin/ruby

=begin
Authors - Christopher Kong, Wilson Thai, Maria Cruz
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
require_relative 'window'

$screen_w = 1280
$screen_h = 960
$rng = Random.new
$line_max = Math.sqrt($screen_w**2 + $screen_h**2)
$max_bounces = -1
$line_thickness = 0.5

RubyRays.new.show
