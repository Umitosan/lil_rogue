class Arrow
  attr_accessor(:x, :y, :z ,:x_vel, :y_vel, :angle)

  def initialize(x, y, angle)
    @x = x
    @y = y
    @z = 1
    @angle = angle
    @x_vel = 0
    @y_vel = 0
    @arrow_img = Gosu::Image.new("img/arrow1_sm.png")
  end

  def reset_vel
    @x_vel = 0
    @y_vel = 0
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
    @arrow_img.draw_rot(@x+32,@y+32,@z,@angle)
  end
end # END ARROW CLASS
