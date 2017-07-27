class Enemy
  attr_accessor(:x, :y, :z, :x_vel, :y_vel, :time_until_move, :speed)

  @@mobs = []

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @speed = 2
    @x_vel = 0
    @y_vel = 0
    @enemy_img = Gosu::Image.new("img/eye1.png")
    # @enemy_img = Gosu::Image.load_tiles("floor2test.png", 25, 25)
    @time_until_move = 500
  end

  def self.get_mobs
    @@mobs
  end

  def self.spawn_mobs(num)
    num.times do |i|
      mob = Enemy.new(WINDOW_WIDTH / 2 - 32,128)
      @@mobs.push(mob)
    end
  end

  def change_dir
    dir = Gosu.random(0.5,6.5).round # using 0.5 - 4.5 to balance out the round method bias
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
    elsif ((dir == 5) || (dir == 6))# WAIT
      @x_vel = 0
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
    #hit box helper
    # draw_rect(@x+8,@y+8,48,48,Colors::Green)
    @enemy_img.draw(@x,@y,@z)
  end
end # END ENEMY CLASS
