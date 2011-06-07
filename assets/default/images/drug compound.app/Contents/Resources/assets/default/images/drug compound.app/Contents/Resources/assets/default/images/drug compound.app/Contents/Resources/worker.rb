class Worker < GameObject
  include PathFind
  attr_accessor :task, :skills, :block, :all_blocks
  
  def setup
    @has_task = false
    @path = []
  end
  
  def needs_task?
    return true if @has_task == false
    return false
  end
  
  def add_task(new_task)
    
    @task = new_task
    @all_blocks.reset_path_find
    
    @path = new_find_path_to(self.block, @task.target.block)
    
   
    @has_task = true
    #puts "task assigned to worker"
  end
  
  def set_target(coords)


  end
  
  def block_coords
    return [self.x/20,self.y/20]
  end
  
  def add_to_block(ablock)
    if ablock.class.name == "GameBlock"
      ablock.add_actor self
      self.block = ablock
    else
      if ablock.class.name == "Array"
        new_block = @all_blocks.block_at(ablock)
        add_to_block(new_block) # lol @ recursion. i think.
      end
    end
  end
  
  def at_target?
    return false if @task.target.block.nil?

    return true if @block.next_to?(@task.target.block)
    return false  
  end
  
  def complete_task

    @task = nil
    @has_task = false
    @path = nil
  end
  
  def move_to_next_path_node

    new_place = @path.pop

     
   
    if new_place.x > @x
      @x += 20
    else
      @x -= 20 if new_place.x < @x
        
    end
    
    if new_place.y > @y
      @y += 20
    else
      @y -= 20 if new_place.y < @y
    end

    
    add_to_block new_place
    @block = @all_blocks.block_at(block_coords)

  end
  
  def update
    unless @has_task == false

      if at_target?

        
        complete_task
      else

        unless @path.nil? || @path.size == 0

          move_to_next_path_node
        else

          @path = new_find_path_to(self.block, @task.target.block)
          move_to_next_path_node
        end
        
 
      end # at_target?
      
    end #has_task?
    
    
  end #update
  
end