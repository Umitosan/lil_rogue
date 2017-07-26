class Hud
  attr_accessor(:score, :last_btn, :arrow_status, :cur_frame, :hearts)

  def initialize
    # .from_text(window, text, font_name, line_height, line_spacing, width, align)
    @score = Gosu::Image.from_text( "SCORE: 00", 20)
    @last_btn = Gosu::Image.from_text( "NONE", 20 )
    @arrow_status = Gosu::Image.from_text( "--", 20 )
    @cur_frame = Gosu::Image.from_text( "0", 20 )
    @hearts = []
  end

  def reset_hearts
    x = 0
    y = 0
    3.times do
      anotherHeart = Heart.new(x,y)
      @hearts.push(anotherHeart)
      x += 63
    end
  end

  def draw
    draw_rect(WINDOW_WIDTH-128, 0, 128, 64, Colors::Black)
    @score.draw(WINDOW_WIDTH-128,0,0)
    @last_btn.draw(WINDOW_WIDTH-128,20,0)
    @arrow_status.draw(WINDOW_WIDTH-128,40,0)
    @cur_frame.draw(0,64,0)
    @hearts.each do |heart|
      heart.draw
    end
  end

end # END ENEMY CLASS


class Heart
  attr_accessor(:x,:y,:image)

  def initialize(x,y)
    @x = x
    @y = y
    @z = 2
    @image = Gosu::Image.new("img/heart1.png", :tileable => true)
  end

  def draw
    draw_rect(0, 0, 192, 64, Colors::LightBlk)
    @image.draw(@x,@y,@z)
  end

end
