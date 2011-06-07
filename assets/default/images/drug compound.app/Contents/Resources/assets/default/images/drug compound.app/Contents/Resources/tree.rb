class Tree < GameObject
  
  attr_accessor :block
  
  def passable?
    true
  end
  
  def grow_tree_randomly(all_trees)
    
    # find a free space
    
    b = self.block
    
    next_blocks = b.all_blocks.blocks_next_to(b)
    new_trees = Array.new
    next_blocks.each do |r|
      if !r.nil? && r.fringe_placeable? && (rand(100) > 33) # 2/3 chance a a forest expanding from a particular tree
         tree = Tree.new(:x => b.x, :y => b.y, :image => "tree1.png")
         r.add_fringe(tree)
         new_trees << tree
       end
    end
    
    new_trees.each do |t|
      all_trees.add_game_object t
    end
  end
  
  
  def self.grow_initial_forests(all_trees, all_blocks)
    new_trees = Array.new
    all_trees.each do |t| #expand current trees by 1 in each direction
      unless t.block.nil?
        all_blocks.blocks_next_to(t.block).each do |b|
           if !b.nil? && b.fringe_placeable? && (rand(100) > 33) # 2/3 chance a a forest expanding from a particular tree
             tree = Tree.new(:x => b.x, :y => b.y, :image => "tree1.png")
             b.add_fringe(tree)
             new_trees << tree
           end
        end
      end
    end
    num = rand(8)
    num.times do  # seed new trees
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

  def self.random_trees(all_trees, number)
    ob = all_trees.of_class(Tree)
    
    if ob.size <= number
      return ob
    end
    
   ob.shuffle!
   return ob[0..number]
    
    
  end
  
  def block_coords
    return self.block.block_coords
  end
  
  def menu_options
    puts "grabbing tree options"
    
    opts = []
    opts << ContextMenuOption.generate("icon_axe.png", "Chop Tree",:target => self, :action => "chop")
    opts << ContextMenuOption.generate("icon_cancel.png","Cancel")

    return opts
  end
end