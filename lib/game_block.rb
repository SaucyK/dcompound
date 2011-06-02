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
  end
  
  def add_actor(actor)
    @actor = actor
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
  end
  
  def self.generate(x, y, floor)
    instance = self.create(:x => x, :y => y)
    instance.add_floor floor
    return instance
    
    
  end
end