class Enemy
  attr_accessor(:x, :y, :z, :x_vel, :y_vel, :time_until_move, :speed)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @speed = 3
    @x_vel = 0
    @y_vel = 0
    @enemy_img = Gosu::Image.new("img/eye1.png")
    @time_until_move = 500
  end

  def change_dir
    dir = Gosu.random(0.5,4.5).round # using 0.5 - 4.5 to balance out the round method bias
    if dir == 1 # UP
      @x_vel = 0
      @y_vel = -1 * @speed
    elsif dir == 2 # DOWN
      @x_vel = 0
      @y_vel = @speed
    elsif dir == 3 # LEFT
      @x_vel = -1 * @speed
      @y_vel = 0
    elsif dir == 4 # RIGHT
      @x_vel = @speed
      @y_vel = 0
    else
      @x_vel = nil
      @y_vel = nil
    end
  end

  def update
    if ((@x + @x_vel) > 64) && ((@x + @x_vel) < WINDOW_WIDTH - 2*64)
      @x += @x_vel
    end
    if ((@y + @y_vel) > 64) && ((@y + @y_vel) < WINDOW_HEIGHT - 2*64)
      @y += @y_vel
    end
  end

  def draw
    @enemy_img.draw(@x,@y,@z)
  end
end # END ENEMY CLASS
