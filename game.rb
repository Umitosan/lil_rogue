require 'rubygems'
require 'gosu'
require 'pry'
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

  def button_down(button)
    case button
    when Gosu::KbLeft then ( @player1.x_vel = -5 )
    when Gosu::KbRight then ( @player1.x_vel = 5 )
    when Gosu::KbUp then ( @player1.y_vel = -5 )
    when Gosu::KbDown then ( @player1.y_vel = 5 )
    when Gosu::KbEscape then ( self.close! )
    when Gosu::KbSpace
      if (@arrows_arr.length < 3)
        myArrow1 = Arrow.new(@player1.x, @player1.y, 0, -10)
        @arrows_arr.push(myArrow1)
      end
    else
      super
    end
  end # END BUTTON DOWN

  def button_up(button)
    case button
    when Gosu::KbLeft then ( @player1.x_vel = 0 )
    when Gosu::KbRight then ( @player1.x_vel = 0 )
    when Gosu::KbUp then ( @player1.y_vel = 0 )
    when Gosu::KbDown then ( @player1.y_vel = 0 )
    else
      super
    end
  end # END BUTTON UP

  ###################################################
  def update
    frame_count
    @player1.update
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

class Player
  attr_accessor(:x, :y, :z ,:x_vel, :y_vel, :facing)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @x_vel = @y_vel = 0
    @x_acc = @x_acc = 0
    @player_img = Gosu::Image.new("img/archer1_sm.png")
    @facing = "up"
  end

  def update
    if @x_vel == -5  ### LEFT
      if ((@x - @x_vel) > 0)
        @x += @x_vel
      end
    end
    if @x_vel == 5   ### RIGHT
      if ((@x + @x_vel) < (WINDOW_WIDTH - 64))
        @x += @x_vel
      end
    end
    if @y_vel == -5  ### LEFT
      if ((@y - @y_vel) > 0)
        @y += @y_vel
      end
    end
    if @y_vel == 5   ### RIGHT
      if ((@y + @y_vel) < (WINDOW_WIDTH - 64))
        @y += @y_vel
      end
    end
  end  # END MOVE

  def reset_vel
    @x_vel = 0
    @y_vel = 0
  end

  def draw
    @player_img.draw(@x,@y,@z, scale_x = 0.5, scale_y = 0.5)
  end
end # END PLAYER CLASS

class Arrow

  attr_accessor(:x, :y, :z ,:x_vel, :y_vel)

  def initialize(x, y, x_vel, y_vel)
    @x = x
    @y = y
    @z = 1
    @x_vel = x_vel
    @y_vel = y_vel
    @arrow_img = Gosu::Image.new("img/arrow1_sm.png")
  end

  def reset_vel
    @x_vel = 0
    @y_vel = 0
  end

  def update
    @x += @x_vel
    @y += @y_vel
  end

  def in_bounds?
    bounds = nil
    if ((@x > 0) && (@x < WINDOW_WIDTH - 64) && (@y > 0) && (@y < WINDOW_HEIGHT - 64))
      bounds = true
    else
      bounds = false
    end
    bounds
  end

  def draw
    @arrow_img.draw(@x,@y,@z)
  end
end  # END ARROW CLASS

class Enemy
  attr_accessor(:x, :y, :z, :x_vel, :y_vel)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @x_vel = @y_vel = 0
    @x_acc = @x_acc = 0
    @enemy_img = Gosu::Image.new("img/eye1.png")
  end

  def draw
    @enemy_img.draw(@x,@y,@z)
  end
end # END ENEMY CLASS


class Hud
  attr_accessor(:score)

  def initialize
    @score = Gosu::Image.from_text( "hello", 30 )
  end

  def draw
    @score.draw(0,0,0)
  end

end


MyWindow.new.show
