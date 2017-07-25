class Hud
  attr_accessor(:score, :last_btn)

  def initialize
    # .from_text(window, text, font_name, line_height, line_spacing, width, align)
    @score = Gosu::Image.from_text( "SCORE", 20, options = {align: :center})
    @last_btn = Gosu::Image.from_text( "NONE", 20 )
  end

  def draw
    draw_rect(WINDOW_WIDTH-128, 0, 128, 64, Colors::Black)
    @score.draw(WINDOW_WIDTH-128,0,0)
    @last_btn.draw(WINDOW_WIDTH-128,20,0)
  end

end # END ENEMY CLASS
