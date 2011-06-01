# grid

class GameGrid
  @@xsize = 0
  @@ysize = 0
  @@tiles = Chingu::GameObjectList.new
  
  def setup(xa, ya)

    @@xsize = xa
    @@ysize = ya
    total = 0
    (1..@@xsize).each do |xc|
      (1..@@ysize).each do |yc|
        total = total + 1
        if total%7==0 || total%13==0
          @@tiles.add_game_object Tile.create(:image => Image["tree1.png"], :x => xc*20, :y => yc*20)
        else
          @@tiles.add_game_object Tile.create(:image => Image["grass1.png"], :x => xc*20, :y => yc*20)
        end
      end
    end

  end
  
  def draw
    @@tiles.draw
  end

end