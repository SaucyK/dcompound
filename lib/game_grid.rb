# grid

class GameGrid
  @xsize = 0
  @ysize = 0
  @@tiles = Chingu::GameObjectList.new
  @@trees = Chingu::GameObjectList.new
  @@blocks = GameObjectList.new
  @@block_ref = Array.new
  def setup(xa, ya)

    @xsize = xa
    @ysize = ya
    total = 0
    (1..(@xsize-1)).each do |xc|
      (1..(@ysize-1)).each do |yc|
        total = total + 1
        floor = Tile.generate_new(xc,yc,"grass")
        block = GameBlock.generate(xc, yc, floor)
        #@@tiles.add_game_object floor
        @@blocks.add_game_object block
      end
    
      
    end

  end
  
  def draw
    @@blocks.draw
  end

end