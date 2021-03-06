# grid

class GameGrid
  attr_accessor :cursor
  @xsize = 0
  @ysize = 0
  @@tiles = Chingu::GameObjectList.new
  @@trees = Chingu::GameObjectList.new
  @@blocks = GameBlockList.new
  @@workers = Chingu::GameObjectList.new
  
  def block_at(coords)
    return @@blocks.block_at(coords)
  end
  
  def all_workers
    return @@workers
  end
  
  def all_blocks
    return @@blocks
  end
  
  def update_workers
    @@workers.each do |w|
      w.update
    end
  end
  
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
          block.all_blocks = @@blocks
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
  
  def add_cursor
    self.cursor = MapCursor.create(:x => 400, :y => 300, :image => Image["cursor.png"])
    self.cursor.grid = self
    
  end
  
  
  def add_worker(x,y)
    worker = Worker.create(:x => x*20, :y => y*20, :image => Image["worker1.png"])
    worker.all_blocks = @@blocks
    worker.add_to_block  @@blocks.block_at([x,y])
    
    @@workers.add_game_object worker
  end
  
  def place_wall(coords)
    wall = Wall.new(:x => coords[0]*20, :y => coords[1]*20, :image => "wall1.png")
    b = @@blocks.block_at(coords)
    b.add_fringe(wall)
    
  end
  
  def update
    @@blocks.update
    #@@workers.update
    self.cursor.update
    
  end
  
  def draw
    @@blocks.draw
    @@workers.draw
    self.cursor.draw
  end

  def timed_tree_growth(num=100)
    Tree.random_trees(@@trees, num).each do |t|
      if t.nil?
        @@trees.remove_game_object(t)
        self.timed_tree_growth(1)
      else
        t.grow_tree_randomly(@@trees)
      end
    end
  end

  
  
end