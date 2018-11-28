# RubyRays Project

This repository contains the source code for a 2D Ray Tracing simulation. It is intended to assist in the visualization of the ray tracing process.

This project is built on Gosu.

### Build

To build this project, Ruby and Gosu are required.

Installation Steps (Windows)
1. Download and run installer for latest. Run everything it asks you to. When prompted, press 3 ENTER to install Ruby + MINSYS2 + MINGW
 https://rubyinstaller.org/downloads/
2. Navigate to C:\Ruby25-x64\msys64 (or wherever you installed it) and save a shortcut to mingw64.exe somewhere. It's a linux shell that you will use to build and run the software.
3. Open mingw64.exe and install Simple2d (our drawing library) by pasting the following (using right click):
`url='https://raw.githubusercontent.com/simple2d/simple2d/master/bin/simple2d.sh'; which curl > /dev/null && cmd='curl -fsSL' || cmd='wget -qO -'; bash <($cmd $url) install`
Press y when prompted.
4. Add ruby to the path by pasting `echo 'export PATH=$PATH:/c/Ruby25-x64/bin' >> .bashrc`. Then, type in `source .bashrc`.
5. Install gosu (our first gem) by typing `gem install gosu`
6. Run our files with `ruby /path/main.rb`! You may need to fish around to find the right path. Mine was on `/c/Users/chickaloo/Documents/rubyrays/libmain.rb`. Alternatively, you may CD (Change Directory) to the proper path using `cd /path/to/files`, and then type `ruby main.rb` to run.
7. (optional) Add the above command as a shortcut so you can avoid retyping every path using `echo 'alias rb="ruby /c/Users/chickaloo/Documents/rubyrays/lib/main.rb"'`. Replace rb with the desired shortcut (make sure it's unused!) and the path with your own. Then, type `source .bashrc`, and then you can begin to use your code.

###Controls

Because a GUI was infeasible with project time constraints, a hotkey system was used instead.

     a      - Move ray origin
     c      - Reduce number of bounces
     d      - Delete shape
     e      - Increase number of bounces
     0      - Spawn Circle at cursor location
     3-9    - Spawn Polygon of N sides at cursor location
     -      - Shrink shape at cursor location
     +      - Grow shape at cursor location
     [      - Rotate shape counterclockwise (left)
     ]      - Rotate shape clockwise (right)
     Arrows - Nudge Shape

### Contribute

The following are objectives for this project -

	[ ] - Convert Debug system into Decorator pattern
	[ ] - Create shape inheritance
	[x] - Create shape management system for collisions and things
	[ ] - Create proper ray system
	[x] - Get Ray Trace Bouncing working
	[ ] - Fix collision bug at 90*i degrees
	[ ] - Add "phong" and other subray effects
	[ ] - Add light sources
	[ ] - Add materials
	[ ] - Add energy system
	[ ] - Optimize
