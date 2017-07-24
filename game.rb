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
    @player1 = Player.new
    @enemy1 = Enemy.new(193,193)
    @floor1 = Gosu::Image.new("img/floor_checker_1_sm.jpg")
    @blue1 = Gosu::Image.new("img/blue1.png", :tileable => true)  ## 32 pixels
    @wall1 = Gosu::Image.new("img/wall1.png", :tileable => true)  ## 64 pixels
  end

  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  # image draw
  # draw(x, y, z, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default) ⇒ void

  # def draw_grass
  #   draw_rect(0, 480, WINDOW_WIDTH, 20, @colorMint)
  #   draw_rect(0, 500, WINDOW_WIDTH, 20, 0x8000ddbb)
  #   draw_rect(0, 520, WINDOW_WIDTH, 20, 0x8000ccbb)
  #   draw_rect(0, 540, WINDOW_WIDTH, 20, 0x8000bbbb)
  #   draw_rect(0, 560, WINDOW_WIDTH, 20, 0x8000aabb)
  #   draw_rect(0, 580, WINDOW_WIDTH, 20, 0x8000aabb)
  # end

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

  def button_down(id)
    case id
    when Gosu::KbLeft
        @player1.x_vel = -5
    when Gosu::KbRight
        @player1.x_vel = 5
    when Gosu::KbUp
      @player1.y_vel = -5
    when Gosu::KbDown
      @player1.y_vel = 5
    when Gosu::KbEscape
      self.close!
    end
  end

  def button_up(id)
    case id
    when Gosu::KbLeft
      @player1.x_vel = 0
    when Gosu::KbRight
      @player1.x_vel = 0
    when Gosu::KbUp
      @player1.y_vel = 0
    when Gosu::KbDown
      @player1.y_vel = 0
    end
  end
  ###################################################
  def update
    frame_count
    @player1.move
  end

  def draw
    draw_floor
    draw_wall
    @enemy1.draw
    @player1.draw(0x90ff0000)
  end
  ###################################################
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

  def draw(color)
    draw_rect(@x, @y, 20, 20, color)
  end
end # END PLAYER


class Enemy
  attr_accessor(:x, :y, :z, :x_vel, :y_vel)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @x_vel = @y_vel = 0
    @x_acc = @x_acc = 0
    @body_img = Gosu::Image.new("img/eye1.png")
  end

  def draw
    @body_img.draw(@x,@y,@z)
  end

end

MyWindow.new.show
