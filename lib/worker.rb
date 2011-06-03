class Worker < GameObject
  attr_accessor :task, :skills
  
  def setup
    @has_task = false
    
  end
  
  def set_target(coords)

    @target_x = coords[0]*20
    @target_y = coords[1]*20
    @has_task = true
  end
  
  def block_coords
    return [self.x/20,self.y/20]
  end
  
  def update
    unless @has_task == false
 
      if @target_x > @x
        @x += 20

      end
      if @target_x < @x
        @x -= 20

      end
      
      if @target_y > @y
        @y += 20

      end
      
      if @target_y < @y
        @y -= 20

      end
      
      if @target_x == @x && @target_y == @y
        @has_task = false

      end
      
    end
    
    
  end
  
end