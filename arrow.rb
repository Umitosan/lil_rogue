class Arrow
  attr_accessor(:x, :y, :z ,:x_vel, :y_vel, :angle, :tip_x, :tip_y)

  def initialize(x, y, angle)
    @x = x
    @y = y
    @z = 1
    @tip_x = 0
    @tip_y = 0
    @angle = angle
    @x_vel = 0
    @y_vel = 0
    @arrow_img = Gosu::Image.new("img/arrow1_sm.png")
  end

  def reset_vel
    @x_vel = 0
    @y_vel = 0
  end

  def set_tip(someAngle)
    if someAngle == 0 # UP
      @tip_x = @x + 32
      @tip_y = @y
    elsif someAngle == 180 # DOWN
      @tip_x = @x + 32
      @tip_y = @y + 64
    elsif someAngle == 270 # LEFT
      @tip_x = @x
      @tip_y = @y + 32
    elsif someAngle == 90 # RIGHT
      @tip_x = @x + 64
      @tip_y = @y + 32
    else
      @tip_x = 0
      @tip_y = 0
    end
  end

  def set_vel(someAngle)
    if someAngle == 0 # UP
      @x_vel = 0
      @y_vel = -10
    elsif someAngle == 180 # DOWN
      @x_vel = 0
      @y_vel = 10
    elsif someAngle == 270 # LEFT
      @x_vel = -10
      @y_vel = 0
    elsif someAngle == 90 # RIGHT
      @x_vel = 10
      @y_vel = 0
    else
      @x_vel = 0
      @y_vel = 0
    end
  end

  def update
    @x += @x_vel
    @y += @y_vel
    set_tip(@angle)
  end

  def in_bounds?
    bounds = nil
    if ((@x > 64) && (@x < WINDOW_WIDTH - 128) && (@y > 64) && (@y < WINDOW_HEIGHT - 128))
      bounds = true
    else
      bounds = false
    end
    bounds
  end

  def draw
    # hit box helper
    # draw_rect(@tip_x,@tip_y,16,16,Colors::Red)
    @arrow_img.draw_rot(@x+32,@y+32,@z,@angle)
  end
end # END ARROW CLASS
