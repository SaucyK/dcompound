class Tree < GameObject
  
  attr_accessor :block
  
  def is_passable?
    true
  end
  
  def grow_tree_randomly
    b = self.block
    
    
    
  end
  
  
  def self.grow_initial_forests(all_trees, all_blocks)
    new_trees = Array.new
    all_trees.each do |t| #expand current trees by 1 in each direction
      unless t.block.nil?
        all_blocks.blocks_next_to(t.block).each do |b|
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
      
      b = all_blocks.block_at([x,y])
      
      if !b.nil? && b.fringe_placeable?
        tree = Tree.new(:x => b.x, :y => b.y, :image => "tree1.png")
        b.add_fringe(tree)
        new_trees << tree
      end 
    end
        
    new_trees.each do |t|
      all_trees.add_game_object t
    end
        
  end

end