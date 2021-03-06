class MapCursor < Chingu::GameObject
  attr_accessor :grid
  def setup
    self.input = {
      :holding_left => :left, 
      :holding_right => :right, 
      :holding_up => :up, 
      :holding_down => :down,
      :space => :set_target,
      :w => :place_wall
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
    @target_x = self.x/20
    @target_y = self.y/20
    @target_available = true
    
  end
  
  def place_wall
    self.grid.place_wall(self.block_coords)
  end
  
  def block_coords
    return [self.x/20,self.y/20]
  end
  
  def left
    self.x -= 20 unless self.x <= 20
  end
  
  def right
    self.x += 20 unless self.x >= 1980
  end
  
  def up
    self.y -= 20 unless self.y <= 20
  end
  
  def down
    self.y += 20 unless self.y >= 1980
  end
  
  def update
    
  end
end