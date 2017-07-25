class Player
  attr_accessor(:x, :y, :z ,:x_vel, :y_vel, :facing)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @x_vel = @y_vel = 5
    @x_acc = @x_acc = 0
    @player_img = Gosu::Image.new("img/archer1_sm.png")
    @facing = "up"
  end

  def move_left
    if ((@x - @x_vel) > 0)
      @x -= @x_vel
    end
  end

  def move_right
    if ((@x + @x_vel) < (WINDOW_WIDTH - 64))
      @x += @x_vel
    end
  end

  def move_up
    if ((@y - @y_vel) > 0)
      @y -= @y_vel
    end
  end

  def move_down
    if ((@y + @y_vel) < (WINDOW_WIDTH - 64))
      @y += @y_vel
    end
  end

  # def update
  #   if @x_vel == -5  ### LEFT
  #     if ((@x - @x_vel) > 0)
  #       @x += @x_vel
  #     end
  #   end
  #   if @x_vel == 5   ### RIGHT
  #     if ((@x + @x_vel) < (WINDOW_WIDTH - 64))
  #       @x += @x_vel
  #     end
  #   end
  #   if @y_vel == -5  ### LEFT
  #     if ((@y - @y_vel) > 0)
  #       @y += @y_vel
  #     end
  #   end
  #   if @y_vel == 5   ### RIGHT
  #     if ((@y + @y_vel) < (WINDOW_WIDTH - 64))
  #       @y += @y_vel
  #     end
  #   end
  # end  # END MOVE

  def reset_vel
    @x_vel = 0
    @y_vel = 0
  end

  def draw
    @player_img.draw(@x,@y,@z, scale_x = 0.5, scale_y = 0.5)
  end
end # END PLAYER CLASS
