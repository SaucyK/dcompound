module PathFind
  
  def find_path_to(coords)
    puts "ok, this is the hard part."
    @tx = coords[0]
    @ty = coords[1]
    
    start = @block.dup
    goal = @block.all_blocks.block_at([@tx,@ty]).dup
    puts "start and end points determined"
    
    start.d = guess_distance(@tx,@ty)
    puts "distance guessed. #{start.d} btw"
    block_set = [start]
    puts "block set started"
    while block_set.size > 0
      puts "ok there's still shit to do in the block set"
      block_set.sort! { |a,b| a.d <=> b.d}
      puts "block set sorted"
      next_node = block_set[0].dup
      puts "next node determined"
      
      
      puts "is path ready?"
      return build_path(goal) if (next_node.x == goal.x) && (next_node.y == goal.y)
      puts "nope!"
      
      block_set.delete_at(0)
      next_node.closed = true
      puts "old block disregarded"
      
      next_node.passable_neighbours.each do |node|
        puts "getting next node"
        unless block_set.include? node
          puts "block no in block set"
          node.previous_cell = next_node
          puts "previous cell set"
          node.d = node.guess_distance(@tx, @ty)
          puts "guessing distance of new node: #{node.d}"
          block_set << node
          puts "node added to block set"
        else
          puts "block is already in the block set"
        end
        
      end
    end
    
    puts "no path :("
    return false #no path
  end
  
  def build_path(end_point)
    puts "hooray! building path"
    results = []
    cell = end_point
    results << cell
    puts "end point added to path"
    while !cell.previous_cell.nil?
      puts "adding next cell to path"
      cell = cell.previous_cell
      results << cell
      
    end 
    puts "all cells added to path"
    
    
    puts "results reversed, returning now"
    return results
  end
  
  def guess_distance(tx, ty)
    puts "guess_distance called!"
    nx = self.x/20
    ny = self.y/20
    distance_guess = Math.sqrt(((tx-nx)**2)+((ty-ny)**2)) # sup pythagarus
    return distance_guess
    
  end
  

  
  def next_nodes
    return []
  end
end