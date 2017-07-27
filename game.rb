require 'rubygems'
require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'arrow'
require_relative 'enemy'
require_relative 'hud'
require_relative 'heart'
require_relative 'room'
require_relative 'map'
require_relative 'exit'
include Gosu

WINDOW_WIDTH = 768
WINDOW_HEIGHT = 768

module Colors
  Black = 0x99000000
  LightBlk = 0x33000000
  Red = 0x80ff0000
  Green = 0x8000ff00
  Blue = 0x800000ff
  Yellow = 0x80ffff00
  Orange = 0x80ff9900
  Mint = 0x8000ffbb
  BrightPurple = 0x80ff00ff
end

module MyImg
  Hearts = Gosu::Image.load_tiles("img/heart1.png", 64, 64)
  EyeStatic = Gosu::Image.new("img/eye1.png")
  EyeAnim = Gosu::Image.load_tiles("img/eye2anim.png", 64, 64, tileable: true)
  Archer = Gosu::Image.new("img/archer1_xs.png")
  Arrow = Gosu::Image.new("img/arrow1_sm.png")
  GameOver = Gosu::Image.new("img/gameover1static.png")
end

# ======================================================================#
# ======================================================================#
# ======================================================================#

class MyWindow < Gosu::Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, :fullscreen => false)
    self.caption = "Little Rogue" # the caption method must come after the window creation "super()"
    @frame = 0
    @arrows_arr = []
    @floor1 = Gosu::Image.new("img/floor_checker_1_sm.jpg", :tileable => true)
    @floor2 = Gosu::Image.new("img/floor2.png", :tileable => true)
    @wall1 = Gosu::Image.new("img/wall1.png", :tileable => true)
    @player1 = Player.new(WINDOW_WIDTH / 2 - 32, WINDOW_HEIGHT-192, 6)
    Enemy.spawn_mobs(3)
    @hud = Hud.new
    @exit = Exit.new(576, 128)
    @game_state = "go"
  end

  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  def draw_floor
    12.times do |i|
      12.times do |j|
        @floor2.draw(i*64, j*64, 0)
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
    if button == Gosu::KbEscape
       self.close!
    elsif button == Gosu::KbSpace
      if (@arrows_arr.length < 3)
        myArrow = Arrow.new(@player1.x, @player1.y, @player1.angle)
        myArrow.set_vel(@player1.angle)
        myArrow.set_tip(@player1.angle)
        @arrows_arr.push(myArrow)
      end
    else
      super
    end
  end # END BUTTON DOWN

  def arrow_hit?(arrow, enemy)
    hit = false
    # test arrow up
    if ( ((arrow.tip_x) > (enemy.x)) ) && ( (arrow.tip_x ) < (enemy.x+48) ) &&
       ( (arrow.tip_y > enemy.y) ) && ( (arrow.tip_y ) < (enemy.y+48) )
      hit = true
    end
    hit
  end

  def player_hit_enemy?(mob)
    #calculate the center point of player and enemy to make this a bit easier
    pCX = @player1.x+32
    pCY = @player1.y+32
    mCX = mob.x+32
    mCY = mob.y+32
    hit = false
    if ( (pCX > mCX-32) && (pCX < mCX+32) && (pCY > mCY-32) && (pCY < mCY+32) )
       hit = true
    end
    hit
  end

  def gameover_menu
    draw_rect(0,0,WINDOW_WIDTH,WINDOW_HEIGHT,Colors::Black)
    MyImg::GameOver.draw(94,128,2)
  end

  ##############################################################
  def update
    if @game_state == "go"
        # 1 seconds timer
        frame_count
        ## Buttons Buttons Buttons
        if Gosu.button_down?(Gosu::KB_LEFT)
          @player1.move_left
          @hud.last_btn = Gosu::Image.from_text( "LEFT", 20 )
        end
        if Gosu.button_down?(Gosu::KB_RIGHT)
          @player1.move_right
          @hud.last_btn = Gosu::Image.from_text( "RIGHT", 20 )
        end
        if Gosu.button_down?(Gosu::KB_UP)
          @player1.move_up
          @hud.last_btn = Gosu::Image.from_text( "UP", 20 )
        end
        if Gosu.button_down?(Gosu::KB_DOWN)
          @player1.move_down
          @hud.last_btn = Gosu::Image.from_text( "DOWN", 20 )
        end
        # arrows
        @arrows_arr.each do |ar|
          if ar.in_bounds?
            Enemy.get_mobs.each do |mob|
              if arrow_hit?(ar, mob)
                Enemy.get_mobs.delete(mob)
                @arrows_arr.delete(ar)
                @hud.add_score
              end
            end
            ar.update
          else
            @arrows_arr.delete(ar)
          end
        end
        ## hud arrows
        if @arrows_arr.length > 0
          @hud.arrow_status = Gosu::Image.from_text( "Arrow OUT", 20 )
        else
          @hud.arrow_status = Gosu::Image.from_text( "----", 20 )
        end
        ## check enemy move time, enemy hit
        Enemy.get_mobs.each do |enemy|
          # enemy, 16.67 milisecond ~= 1 second
          if ((Gosu.milliseconds % enemy.time_until_move) <= 16.67)
            enemy.change_dir
          end
          if player_hit_enemy?(enemy)
            @hud.player_hit = Gosu::Image.from_text( "player hit!", 20 )
            if @player1.invul == false
              @player1.begin_invul
              if @player1.life > 1
                @player1.life -= 1
                @hud.update_hearts(@player1.life)
              else
                # GAME OVER!!!!!!!!
                @game_state = "gameover"
              end
            end
          end
          enemy.update
        end
        if @player1.invul == true
          @player1.update_invul
        end
      end # END IF GAME == "GO"
    @exit.update
  end # END UPDATE

  def draw
    draw_floor
    draw_wall
    @exit.draw
    @hud.draw
    if (@arrows_arr.length != 0)
      @arrows_arr.each do |ar|
        ar.draw
      end
    end
    Enemy.get_mobs.each { |enemy| enemy.draw }
    @player1.draw
    if @game_state == "gameover"
      gameover_menu
    end
  end
  ##############################################################
end # END MyWindow


# ======================================================================#
# ======================================================================#
# ======================================================================#


MyWindow.new.show
