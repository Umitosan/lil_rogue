require 'rubygems'
require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'arrow'
require_relative 'enemy'
require_relative 'hud'
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
    @player1 = Player.new(320,320)
    @enemy1 = Enemy.new(193,193)
    @arrows_arr = []
    @floor1 = Gosu::Image.new("img/floor_checker_1_sm.jpg")
    @blue1 = Gosu::Image.new("img/blue1.png", :tileable => true)  ## 32 pixels
    @wall1 = Gosu::Image.new("img/wall1.png", :tileable => true)  ## 64 pixels
    @hud = Hud.new
  end

  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  def draw_floor
    corner = 0
    6.times do |i|
      6.times do |j|
        @floor1.draw(i*128, j*128, 0) # top row
      end
    end
  end

  def draw_wall
    corner = 0
    12.times do |i|
      @wall1.draw(corner, 0, 0) # top row
      @wall1.draw(corner, 704, 0) # bottom row
      @wall1.draw(0, corner, 0) # left row
      @wall1.draw(704, corner, 0) # right row
      corner += 64
    end
  end

  def frame_count
    if (@frame == 60)
      @frame = 1
    end
    @frame += 1
  end

  # def btn_down_any?
  #
  # end

  def button_down(button)
    if button == Gosu::KbEscape
       self.close!
    else
      super
    end
  end # END BUTTON DOWN

  # def button_up(button)
  #   case button
  #   when Gosu::KbLeft then ( @player1.x_vel = 0 )
  #   when Gosu::KbRight then ( @player1.x_vel = 0 )
  #   when Gosu::KbUp then ( @player1.y_vel = 0 )
  #   when Gosu::KbDown then ( @player1.y_vel = 0 )
  #   else
  #     super
  #   end
  # end # END BUTTON UP

  ###################################################
  def update
    frame_count
    @player1.move_left if Gosu.button_down?(Gosu::KB_LEFT)
    @player1.move_right if Gosu.button_down?(Gosu::KB_RIGHT)
    @player1.move_up if Gosu.button_down?(Gosu::KB_UP)
    @player1.move_down if Gosu.button_down?(Gosu::KB_DOWN)
    # @player1.update
    @arrows_arr.each do |ar|
      if ar.in_bounds?
        ar.update
      else
        @arrows_arr.delete(ar)
      end
    end
  end # END UPDATE

  def draw
    draw_floor
    draw_wall
    @enemy1.draw
    @player1.draw
    if (@arrows_arr.length != 0)
      @arrows_arr.each do |ar|
        ar.draw
      end
    end
    @hud.draw
  end
  ###################################################
end # END MyWindow


# ======================================================================#
# ======================================================================#
# ======================================================================#


MyWindow.new.show
