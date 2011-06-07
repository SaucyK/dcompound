module PathFind
  
  
  def new_find_path_to(start, goal)
    it_count = 0
    open = NodeQueue.new
    closed = NodeQueue.new
    start.calc_h(goal)
    open.push(start)

    start.g = 10 
    while !open.empty? do
      it_count += 1
      current_node = open.find_best
      
      if current_node.same_as?(goal)  #solution
        #puts "Total count: #{it_count}"
        return complete_path(current_node, start)
      end
      
      current_node.passable_neighbours.each do |next_node|
        next_node.calc_g(current_node)
        if open_successor=open.find(next_node)
          if open_successor<=next_node
            next
          end
        end
        if closed_successor=closed.find(next_node)
          if closed_successor<=next_node
            next
          end
        end
      
      
        open.remove(next_node)
        closed.remove(next_node)
      
        next_node.parent = current_node
        
        next_node.calc_h(goal)
      
        open.push(next_node)
      end #neighbours.eahc
      
      closed.push(current_node)
    
    end #while !open.empty
    
    
  end
  
  def complete_path(end_node, start)
    new_path = Array.new
    
    #puts "bulding complete path to #{end_node}"
    new_path << end_node
    next_node = end_node.parent
    until next_node==start do
      #puts "adding #{next_node}"
      new_path << next_node
      next_node=next_node.parent
    end
    
    #puts "path building compelte"
    
    return new_path
  end
  

  
  def build_path(end_point)
   # puts "hooray! building path"
    results = []
    cell = end_point
    results << cell
    #puts "end point added to path"
    while !cell.previous_cell.nil?
     # puts "adding next cell to path"
      cell = cell.previous_cell
      results << cell
      
    end 
    #puts "all cells added to path"
    
    results.reverse!
    #puts "results reversed, returning now"
    return results
  end
  
  def guess_distance(tx, ty)
    #puts "guess_distance called!"
    nx = self.x/20
    ny = self.y/20
    #distance_guess = Math.sqrt(((tx-nx)**2)+((ty-ny)**2)) # sup pythagarus
    distance_guess = (tx-nx).abs+(ty-ny).abs
    return distance_guess
    
  end
  

  
  def next_nodes
    return []
  end
end