class MapCursor < Chingu::GameObject
  
  def setup
    self.input = {
      :left => :left, 
      :right => :right, 
      :up => :up, 
      :down => :down,
      :space => :set_target
      }
      
      @target_available = false
    
  end

  def get_target
    @target_available = false
    return [@target_x, @target_y]
    
  end
  
  def target_available?
    return true if @target_available == true
    return false
  end
  
  def set_target
    @target_x = self.x
    @target_y = self.y
    @target_available = true
    
  end
  
  def left
    self.x -= 20
  end
  
  def right
    self.x += 20
  end
  
  def up
    self.y -= 20
  end
  
  def down
    self.y += 20
  end
  
  def update
    
  end
end