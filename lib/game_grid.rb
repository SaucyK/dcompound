# grid

class GameGrid
  @xsize = 0
  @ysize = 0
  @@tiles = Chingu::GameObjectList.new
  @@trees = Chingu::GameObjectList.new
  @@blocks = GameBlockList.new

  def setup(xa, ya)

    @xsize = xa
    @ysize = ya
    @@blocks.setup(xa, ya)
    total = 0
    puts "laying turf"
    (1..(@xsize-1)).each do |xc|


      (1..(@ysize-1)).each do |yc|
        
        total = total + 1
        floor = Tile.generate_new(xc,yc,"grass")
        block = GameBlock.generate(xc, yc, floor)
        #@@tiles.add_game_object floor
        #puts "generated turf:"
        #puts block.to_s
        #puts "\n\n"
        @@blocks.add_block block
        #puts "laid turf: "
        #puts @@blocks.block_at([xc,yc]).to_s

      end

      
    end
    puts "planting trees"
    num = rand(30)
    num = 8 if num < 8
    num.times do 
      x = rand(@xsize)
      y = rand(@ysize)
       
      
      #puts "looking for block at [#{x},#{y}]"
      b = @@blocks.block_at([x,y])
      #puts "found block:"
      #puts b.to_s
      unless b.nil?
        tree = Tree.new(:x => x*20, :y => y*20, :image => "tree1.png")
        b.add_fringe(tree) unless b.nil?
        @@trees.add_game_object tree unless b.nil?
      end
    end
    
    puts "growing forest"
      3.times do 
        Tree.grow_initial_forests(@@trees, @@blocks)
      end

    
    
  end
  
  def draw
    @@blocks.draw
  end



  
  
end