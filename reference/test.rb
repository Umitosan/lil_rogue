require 'rubygems'
require 'gosu'
require 'pry'
include Gosu

class GameWindow < Gosu::Window
  # The constructor initializes the Gosu::Window base class. The parameters shown here create a 640x480 pixels large window. It also sets the caption of the window, which is displayed in its title bar.
    # You can create a fullscreen window by passing :fullscreen => true after the width and height.
  # Gosu::Image#initialize takes two arguments, the filename and an (optional) options hash. Here we set :tileable to true.
  # Basically, you should use :tileable => true for background images and map tiles.
  def initialize
    super 640, 640
    self.caption = "Gosu Tutorial Game"
  end

  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  def update

  end

  def draw
    draw_rect(0,0,640,640,0x60AAFFAA)
  end
end

window = GameWindow.new
# Then follows the main program. We create a window and call its show() method,
  # which does not return until the window has been closed by the user or by calling close().
window.show
