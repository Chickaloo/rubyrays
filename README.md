#RubyRays Project

This repository contains the source code for a 2D Ray Tracing simulation. It is intended to assist in the visualization of the ray tracing process.

This project is built on Ruby2D.

###Build

To build this project, Ruby, Simple2d, and Ruby2D are required.

Installation Steps (Windows)
1. Download and run installer for latest. Run everything it asks you to. When prompted, press 3 ENTER to install Ruby + MINSYS2 + MINGW
 https://rubyinstaller.org/downloads/
2. Navigate to C:\Ruby25-x64\msys64 (or wherever you installed it) and save a shortcut to mingw64.exe somewhere. It's a linux shell that you will use to build and run the software.
3. Open mingw64.exe and install Simple2d (our drawing library) by pasting the following (using right click):
`url='https://raw.githubusercontent.com/simple2d/simple2d/master/bin/simple2d.sh'; which curl > /dev/null && cmd='curl -fsSL' || cmd='wget -qO -'; bash <($cmd $url) install`
Press y when prompted.
4. Add ruby to the path by pasting `echo 'export PATH=$PATH:/c/Ruby25-x64/bin' >> .bashrc`. Then, type in `source .bashrc`.
5. Install ruby2d (our first gem) by typing `gem install ruby2d`
6. Run our files with `ruby /path/main.rb`! You may need to fish around to find the right path. Mine was on `/c/Users/chickaloo/Documents/rubyrays/main.rb`. Alternatively, you may CD (Change Directory) to the proper path using `cd /path/to/files`, and then type `ruby main.rb` to run.
6b (optional). Add the above command as a shortcut so you can avoid retyping every path using `echo 'alias rb="ruby /c/Users/chickaloo/Documents/rubyrays/main.rb"'`. Replace rb with the desired shortcut (make sure it's unused!) and the path with your own. Then, type `source .bashrc`, and then you can begin to use your code.

###Controls

Because a GUI was infeasible with project time constraints, a hotkey system was used instead.

a - Move ray origin
s - Remove shape at cursor location
d - Show Debug Text
f - Toggle mouse tracking
q - Spawn Circle at cursor location
w - Spawn Triangle at cursor location
e - Spawn Square at cursor location
r - Randomize shape color  at cursor location
t - Grow shape at cursor location
g - Shrink shape at cursor location
h - Show Help Menu
