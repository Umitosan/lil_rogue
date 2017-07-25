class Hud
  attr_accessor(:score, :btn_press, :left_btn, :right_btn, :up_btn, :down_btn)

  def initialize
    # .from_text(window, text, font_name, line_height, line_spacing, width, align)
    @score = Gosu::Image.from_text( "SCORE", 20, options = {:align => :right})
    @btn_press = Gosu::Image.from_text( "FALSE", 20 )
  end

  def draw
    @score.draw(0,0,0)
    @btn_press.draw(0,0,0)
  end
end # END ENEMY CLASS
