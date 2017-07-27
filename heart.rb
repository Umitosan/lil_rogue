

class Heart
  attr_accessor(:x,:y,:image)

  def initialize(x,y,image)
    @x = x
    @y = y
    @z = 2
    @status = 0
    @image = image
  end

  def draw
    draw_rect(0, 0, 192, 64, Colors::LightBlk)
    @image.draw(@x,@y,@z)
  end

end
