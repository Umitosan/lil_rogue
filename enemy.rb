class Enemy
  attr_accessor(:x, :y, :z, :x_vel, :y_vel)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @x_vel = @y_vel = 0
    @x_acc = @x_acc = 0
    @enemy_img = Gosu::Image.new("img/eye1.png")
  end

  def draw
    @enemy_img.draw(@x,@y,@z)
  end
end # END ENEMY CLASS
