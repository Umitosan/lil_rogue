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
require_relative 'tile'
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
  Floor1 = Gosu::Image.new("img/floor_checker_1_sm.jpg", :tileable => true)
  Floor2 = Gosu::Image.new("img/floor2.png", :tileable => true)
  Wall1 = Gosu::Image.new("img/wall1.png", :tileable => true)
  Hearts = Gosu::Image.load_tiles("img/heart1.png", 64, 64)
  EyeStatic = Gosu::Image.new("img/eye1.png", :tileable => true)
  EyeAnim = Gosu::Image.load_tiles("img/eye2anim.png", 64, 64, tileable: true)
  Archer = Gosu::Image.new("img/archer1_xs.png")
  Arrow = Gosu::Image.new("img/arrow1_sm.png")
  GameOver = Gosu::Image.new("img/gameover1static.png")
  GameWin = Gosu::Image.new("img/youwin1.png")
  Welcome = Gosu::Image.new("img/welcome1.png")
end

# ======================================================================#
# ======================================================================#
# ======================================================================#

class MyWindow < Gosu::Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, :fullscreen => false)
    self.caption = "Little Rogue" # the caption method must come after the window creation "super()"
    @welcome = MyImg::Welcome
    self.reset_game
    @game_state = "start"
  end

  # the built-in 'draw_quad' method is redefined for simplicity
  def draw_rect(x, y, w, h, color)
    draw_quad x, y, color, x + w, y, color,
              x, y + h, color, x + w, y + h, color
  end

  def frame_count
    if (@frame == 60)
      @frame = 1
    end
    @frame += 1
  end

  def reset_game
    @cur_room = Room.new(ROOM1)
    @player1 = Player.new(WINDOW_WIDTH / 2 - 32, WINDOW_HEIGHT-192, 6)
    @hud = Hud.new
    @frame = 0
    @arrows_arr = []
    Enemy.spawn_mobs(6)
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
    elsif (button == Gosu::KbS)
      if (@game_state == "start")
        @game_state = "go"
      elsif (@game_state == "gamewin")
        @game_state = "go"
        reset_game
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

  def gamestart_menu
    draw_rect(0,0,WINDOW_WIDTH,WINDOW_HEIGHT,Colors::Black)
    MyImg::Welcome.draw(164,128,2)
    startText = Gosu::Image.from_text( " Press 'S' to Start! ", 40 )
    startText.draw(WINDOW_WIDTH/2-155,WINDOW_HEIGHT/2+200,2,1,1)
  end

  def gameover_menu
    draw_rect(0,0,WINDOW_WIDTH,WINDOW_HEIGHT,Colors::Black)
    MyImg::GameOver.draw(100,110,2)
  end

  def gamewin_menu
    draw_rect(0,0,WINDOW_WIDTH,WINDOW_HEIGHT,Colors::Black)
    MyImg::GameWin.draw(94,128,2)
    insertCoinTxt = Gosu::Image.from_text( " Press 'S' to play again! ", 40 )
    insertCoinTxt.draw(WINDOW_WIDTH/2-155,WINDOW_HEIGHT/2+180,2,1,1)
  end

  ##############################################################
  def update
    if @game_state == "go"
        # 1 seconds timer
        frame_count
        # update exit animation by updating room
        @cur_room.update
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
        if Enemy.get_mobs.length == 0
          # YOU WIN!!
          @game_state = "gamewin"
        end
      end # END IF GAME == "GO"
  end # END UPDATE

  def draw
    @cur_room.draw
    @hud.draw
    if (@arrows_arr.length != 0)
      @arrows_arr.each do |ar|
        ar.draw
      end
    end
    Enemy.get_mobs.each { |enemy| enemy.draw }
    @player1.draw
    if @game_state == "start"
      gamestart_menu
    elsif @game_state == "gameover"
      gameover_menu
    elsif @game_state == "gamewin"
      gamewin_menu
    end
  end
  ##############################################################
end # END MyWindow


# ======================================================================#
# ======================================================================#
# ======================================================================#

gameWindow = MyWindow.new
gameWindow.show
