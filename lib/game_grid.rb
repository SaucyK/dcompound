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
        self.grow_initial_forests
      end

    
    
  end
  
  def draw
    @@blocks.draw
  end


  def blocks_next_to block
    bx = block.x/20
    by = block.y/20
    ab = Array.new
    
    # top left
    unless bx <= 0 && by <= 0
      ab << @@blocks.block_at([bx-1,by-1]) unless @@blocks.block_at([bx-1,by-1]).nil?
    end  
    
    # top center
    unless by <= 0 
      ab << @@blocks.block_at([bx,by-1]) unless @@blocks.block_at([bx,by-1]).nil?
    end
    
    # top right
    unless by <= 0 and bx >= GAME_X_SIZE
      ab << @@blocks.block_at([bx+1,by-1]) unless @@blocks.block_at([bx+1,by-1]).nil?
    end
    
    # center right
    unless bx >= GAME_X_SIZE
      ab << @@blocks.block_at([bx+1,by]) unless @@blocks.block_at([bx+1,by]).nil?
    end
    
    # bottom right
    unless by >= GAME_Y_SIZE &&  bx >= GAME_Y_SIZE
      ab << @@blocks.block_at([bx+1,by+1]) unless @@blocks.block_at([bx+1,by-1]).nil?
    end
    
    # bottom center
    unless by >= GAME_Y_SIZE
      ab << @@blocks.block_at([bx,by+1]) unless @@blocks.block_at([bx,by-1]).nil?
    end
    
    # bottom left
    unless by >= GAME_Y_SIZE && bx <= 0
      ab << @@blocks.block_at([bx-1,by+1]) unless @@blocks.block_at([bx-1,by+1]).nil?
    end
    
    # center left
    unless bx <= 0
      ab << @@blocks.block_at([bx-1,by]) unless @@blocks.block_at([bx-1,by]).nil?
    end
    
  end
  
  def grow_initial_forests
    new_trees = Array.new
    @@trees.each do |t| #expand current trees by 1 in each direction
      unless t.block.nil?
        self.blocks_next_to(t.block).each do |b|
           if !b.nil? && b.fringe_placeable? && (rand(100) > 33)
             tree = Tree.new(:x => b.x, :y => b.y, :image => "tree1.png")
             b.add_fringe(tree)
             new_trees << tree
           end
        end
      end
    end
    num = rand(8)
    num.times do 
      x = rand(GAME_X_SIZE)
      y = rand(GAME_Y_SIZE) 
      
      b = @@blocks.block_at([x,y])
      
      if !b.nil? && b.fringe_placeable?
        tree = Tree.new(:x => b.x, :y => b.y, :image => "tree1.png")
        b.add_fringe(tree)
        new_trees << tree
      end 
    end
        
    new_trees.each do |t|
      @@trees.add_game_object t
    end
        
  end
  
  
end