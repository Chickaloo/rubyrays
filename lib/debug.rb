require 'ruby2d'
require 'ruby2d/window'

$texts = []

$texts[0] = Text.new(
  '',
  x: 25, y: 25,
  size: 20
)
$texts[1] = Text.new(
  '',
  x: 25, y: 65,
  size: 20,
  color: 'green'
)

class Debug
  def tick()
    $texts[0].text = 'FPS: ' + Ruby2D::Window.get(:fps).to_s
    if Ruby2D::Window.get(:fps).to_i > 50
      $texts[0].color = 'green'
    else
      $texts[0].color = 'red'
    end

    mx = get(:mouse_x).to_s
    my = get(:mouse_y).to_s

    $texts[1].text = 'Mouse: ' + mx + ' ' + my
  end
end
