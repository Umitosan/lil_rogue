class Hud
  attr_accessor(:score, :score_img, :last_btn, :arrow_status, :cur_frame, :hearts, :player_hit)

  def initialize
    # .from_text(window, text, font_name, line_height, line_spacing, width, align)
    @score = 0
    @score_img = Gosu::Image.from_text( "SCORE: 0", 20)
    @last_btn = Gosu::Image.from_text( "NONE", 20 )
    @arrow_status = Gosu::Image.from_text( "----", 20 )
    @cur_frame = Gosu::Image.from_text( "0", 20 )
    @player_hit = Gosu::Image.from_text( "####", 20 )
    @hearts = []
    reset_hearts
  end

  def add_score
    @score += 1
    @score_img = Gosu::Image.from_text( "SCORE: #{@score}", 20)
  end

  def reset_hearts
    x = 0
    y = 0
    3.times do
      anotherHeart = Heart.new(x,y, MyImg::Hearts[0])
      @hearts.push(anotherHeart)
      x += 63
    end
  end

  def update_hearts(life)
    if life == 0
      @hearts[0].image = MyImg::Hearts[2]
    elsif life == 1
      @hearts[0].image = MyImg::Hearts[1]
    elsif life == 2
      @hearts[1].image = MyImg::Hearts[2]
    elsif life == 3
      @hearts[1].image = MyImg::Hearts[1]
    elsif life == 4
      @hearts[2].image = MyImg::Hearts[2]
    elsif life == 5
      @hearts[2].image = MyImg::Hearts[1]
    end
  end

  def draw
    draw_rect(WINDOW_WIDTH-128, 0, 128, 64, Colors::Black)
    @score_img.draw(WINDOW_WIDTH-128,0,0)
    @last_btn.draw(WINDOW_WIDTH-128,20,0)
    @arrow_status.draw(WINDOW_WIDTH-128,40,0)
    @cur_frame.draw(0,64,0)
    @player_hit.draw(192,0,1)
    @hearts.each do |heart|
      heart.draw
    end
  end

end # END HUD CLASS
