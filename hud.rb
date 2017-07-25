class Hud
  attr_accessor(:score, :last_btn)

  def initialize
    # .from_text(window, text, font_name, line_height, line_spacing, width, align)
    @score = Gosu::Image.from_text( "SCORE", 20, options = {align: :center})
    @last_btn = Gosu::Image.from_text( "NONE", 20 )
  end

  def draw
    @score.draw(680,0,0)
    @last_btn.draw(680,40,0)
  end
end # END ENEMY CLASS
