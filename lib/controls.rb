require 'ruby2d'

on :key_up do |event|
  case event.key
  when "d"
    $debug = !$debug
    $texts[0].text = ''
    $texts[1].text = ''
  end
end
