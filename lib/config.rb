=begin
:title 	          The title of the window. Default: "Ruby 2D"
:background 	    The background color of the window. Any valid Ruby 2D Color is acceptable. Default: "black"
:width 	          The width of the window in pixels. Default: 640
:height 	        The height of the window in pixels. Default: 480
:viewport_width 	The width of the viewport in pixels, the visible part of the window. Default is the width of the window at the time show is called.
:viewport_height 	Same as :viewport_width above, but for setting the height.
:resizable 	      Determines if the window can be resized, either true or false. Default: false
:borderless 	    Determines if the window has a border, either true or false. Default: false
:fullscreen 	    Determines if the window will be shown in fullscreen mode, either true or false. Default: false
:diagnostics 	    Prints debugging information to the console, either true or false. This is mostly useful when working on Ruby 2D itself. Default: false
=end
require 'ruby2d'

w = 1280
h = 720

set title: '2D Ray Tracer'
set background: 'black'
set width: w
set height: h
set resizable: true
set borderless: false
set fullscreen: false
set diagnostics: true
