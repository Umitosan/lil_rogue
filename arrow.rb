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
end # END ARROW CLASS
