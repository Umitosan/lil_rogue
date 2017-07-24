require 'rubygems'
require 'gosu'
include Gosu

# ======================================================================#
# ======================================================================#
# ======================================================================#


WINDOW_WIDTH = 768
WINDOW_HEIGHT = 768


class MyWindow < Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    @frame = 0
    @colorRed = 0x80ff0000
    @colorGreen = 0x8000ff00
    @colorBlue = 0x800000ff
    @colorYellow = 0x80ffff00
    @colorOrange = 0x80ff9900
    @colorMint = 0x8000ffbb
    @colorBrightPurple = 0x80ff00ff
    @player1 = Player.new
    @blue1 = Gosu::Image.new("img/blue1.png", :tileable => true)  ## 32 pixels
    @wall1 = Gosu::Image.new("img/wall1.png", :tileable => true)  ## 64 pixels
  end

  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  # def draw_grass
  #   draw_rect(0, 480, WINDOW_WIDTH, 20, @colorMint)
  #   draw_rect(0, 500, WINDOW_WIDTH, 20, 0x8000ddbb)
  #   draw_rect(0, 520, WINDOW_WIDTH, 20, 0x8000ccbb)
  #   draw_rect(0, 540, WINDOW_WIDTH, 20, 0x8000bbbb)
  #   draw_rect(0, 560, WINDOW_WIDTH, 20, 0x8000aabb)
  #   draw_rect(0, 580, WINDOW_WIDTH, 20, 0x8000aabb)
  # end

  def draw_wall

  end

  def frame_count
    if (@frame == 60)
      @frame = 1
    end
    @frame += 1
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
        @player1.x_vel = -5
    when Gosu::KbRight
        @player1.x_vel = 5
    end
  end

  def button_up(id)
    case id
    when Gosu::KbLeft
      @player1.x_vel = 0
    when Gosu::KbRight
      @player1.x_vel = 0
    end
  end

  def update  ### UPDATE ############################
    frame_count
    @player1.move
  end

  def draw ### DRAW ##################################
    # draw_rect(0, 0, 800, 480, 0x400000ff)       # sky
    # draw_grass
    draw_wall
    @player1.draw(0x90ff0000)
  end
end # END MyWindow

# ======================================================================#
# ======================================================================#
# ======================================================================#

class Player
  attr_accessor(:x, :y, :x_vel, :y_vel)

  def initialize
    @x = 250
    @y = 460
    @x_vel = @y_vel = 0
    @x_acc = @x_acc = 0
  end

  def move
    if @x_vel == -5  ### LEFT
      if ((@x - @x_vel) > 0)
        @x += @x_vel
      end
    end
    if @x_vel == 5   ### RIGHT
      if ((@x + @x_vel) < (WINDOW_WIDTH - 20))
        @x += @x_vel
      end
    end
    @y += @y_vel
  end

  def reset_vel
    @x_vel = 0
    @y_vel = 0
  end

  def draw(color)
    draw_rect(@x, @y, 20, 20, color)
  end
end # END Player


MyWindow.new.show
