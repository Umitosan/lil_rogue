class Room
  attr_accessor(:tiles,:exit)

  def initialize(blueprint)
    @tiles = []
    @exit = Exit.new(576, 128, 1)
    12.times do
      row = []
      12.times do
        row.push("nil")
      end
      @tiles.push(row)
    end
    blueprint.each_with_index do |row, r|
      row.each_with_index do |type_str, c|
        @tiles[r][c] = Tile.new(type_str)
      end
    end
  end

  def draw
    @tiles.each_with_index do |tileArr, r|
      tileArr.each_with_index do |tile, c|
        tile.img.draw(c*64, r*64, 0)
      end
    end
    @exit.draw
  end

  def update
    @exit.update
  end

end # END Room Class


ROOM1 = [
      ["w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1"]
]

ROOM2 = [
      ["w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","w1","w1","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","w1","w1","w1","w1","w1","w1","f2","f2","w1"],
      ["w1","f2","f2","f2","w1","w1","w1","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","f2","f2","f2","f2","f2","f2","f2","f2","f2","f2","w1"],
      ["w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1","w1"]
]
