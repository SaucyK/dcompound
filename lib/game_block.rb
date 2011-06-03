class GameBlock < GameObject
  # Layers
  # ---
  # floor - grass, dirt /stairs
  # filling - rock / dirt / water
  # fringe - trees / chests / doors
  # actor - workers
  
  
  def add_floor(tile)
    @floor = tile
  end
  
  def add_filling(filling)
    @filling = filling
  end
  
  def add_fringe(fringe)
    @fringe = fringe
    fringe.block = self
  end
  
  def add_actor(actor)
    @actor = actor
  end
  
  def fringe_placeable?
    return false unless @fringe.nil? # carry on if there's no fringe
    return false unless @filling.nil?
    return true
  end
  
  def passable?
    
  end
  
  def block_coords
    return [self.x/20,self.y/20]
  end
  
  def draw
    #if @filling.nil?
    #  @floor.draw
    #else
    #  @filling.draw
    #end
    
    #@fringe.draw unless @fringe.nil?
    #@actor.draw unless @actor.nil?
    
    @floor.draw
    @fringe.draw unless @fringe.nil?
  end
  
  def to_s
    lol = ""
    lol += "Block at => [#{self.x},#{self.y}]:\n"
    lol += "\t has floor? "
    lol += @floor.nil? ? "N\n" : "Y\n"
    lol += "\t has fringe? "
    lol += @fringe.nil? ? "N\n" : "Y\n"
    return lol
  end
  
  def self.generate(x, y, floor)
    instance = self.create(:x => x*20, :y => y*20)
    instance.add_floor floor
    return instance
    
    
  end
  
  
end
