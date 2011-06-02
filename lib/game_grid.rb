# grid

class GameGrid
  @xsize = 0
  @ysize = 0
  @@tiles = Chingu::GameObjectList.new
  @@trees = Chingu::GameObjectList.new
  @@blocks = Chingu::GameObjectList.new
  
  def setup(xa, ya)

    @xsize = xa
    @ysize = ya
    total = 0
    (1..@xsize).each do |xc|
      (1..@ysize).each do |yc|
        total = total + 1
        floor = Tile.generate_new(xc,yc,"grass")
        
        #@@tiles.add_game_object floor
        @@blocks.add_game_object GameBlock.generate(xc, yc, floor)
      end
    end

  end
  
  def draw
    @@blocks.draw
  end

end