class Player
  attr_accessor(:x, :y, :z ,:x_vel, :y_vel, :angle, :life, :invul)

  def initialize(spawn_x,spawn_y,life)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @angle = 0
    @x_vel = @y_vel = 5
    @x_acc = @x_acc = 0
    @player_img = Gosu::Image.new("img/archer1_xs.png")
    @life = life
    @invul = false
    @invul_duration = 1000
    @invul_start_time = nil
  end

  def begin_invul
    @invul_start_time = Gosu.milliseconds
    @invul = true
  end

  def update_invul
    now = Gosu.milliseconds
    if ((now - @invul_start_time) > @invul_duration)
      @invul = false
    end
  end

  def move_left
    if ((@x - @x_vel) > 64)
      @x -= @x_vel
      @angle = 270
    end
  end
  def move_right
    if ((@x + @x_vel) < (WINDOW_WIDTH - 2*64))
      @x += @x_vel
      @angle = 90
    end
  end
  def move_up
    if ((@y - @y_vel) > 64)
      @y -= @y_vel
      @angle = 0
    end
  end
  def move_down
    if ((@y + @y_vel) < (WINDOW_WIDTH - 2*64))
      @y += @y_vel
      @angle = 180
    end
  end

  def draw
    @player_img.draw_rot(@x+32,@y+32,@z,@angle)
  end
end # END PLAYER CLASS
