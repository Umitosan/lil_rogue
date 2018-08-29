class Tile
  attr_accessor(:type, :img, :solid)

  def initialize(type)
    @type = type
    @solid = nil
    if type == "f1"
      @img = MyImg::Floor1
      @solid = false
    elsif type == "f2"
      @img = MyImg::Floor2
      @solid = false
    elsif type == "w1"
      @img = MyImg::Wall1
      @solid = true
    else
      nil
    end
  end

end
