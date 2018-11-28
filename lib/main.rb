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
require_relative 'window'

$screen_w = 1280
$screen_h = 960
$rng = Random.new
$line_max = Math.sqrt($screen_w*$screen_w + $screen_h*$screen_h)

RubyRays.new.show
