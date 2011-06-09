class GameBlock < GameObject
  include Node
  # Layers
  # ---
  # floor - grass, dirt /stairs
  # filling - rock / dirt / water
  # fringe - trees / chests / doors
  # actor - workers
  attr_accessor :all_blocks, :d, :closed, :previous_cell, :function
  
  def add_floor(tile)
    @floor = nil
    
    @floor = tile
    @floor.block = self
  end
  
  def storage?
    return true if self.function == :storage
    return false
  end
  
  def farm?
    return true if self.function == :farm
    return false
  end
  
  def add_filling(filling)
    @filling = filling
  end
  
  def add_fringe(fringe)
    @fringe = fringe
    @fringe.block = self
  end
  
  def remove_fringe
    @fringe.block = nil
    @fringe = nil
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
    return false unless @filling.nil? #check filling first, it's quicker
    return false if !@fringe.nil? && !@fringe.passable?
    return true
  end
  
  def block_coords
    return [self.x/20,self.y/20]
  end
  
  def anything_selected?
    return true if @actor && @actor.respond_to?("selected?") && @actor.selected?
    return true if @fringe && @fringe.respond_to?("selected?") && @fringe.selected?
    return true if @filling && @filling.respond_to?("selected?") && @filling.selected?
    return true if @floor && @floor.respond_to?("selected?") && @floor.selected?
    return false
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
    if anything_selected?
      draw_selected
    else
      @selected.destroy! unless @selected.nil?
      @selected = nil unless @selected.nil?
    end
  end
  
  def draw_selected
    unless @selected
      @selected = GameObject.create(:image => Image["selected.png"], :x => self.x, :y => self.y)
    end
    @selected.draw
    
  end
  
  def to_s
    lol = ""
    lol += "Block at => [#{self.x},#{self.y}]:\n"
    #lol += "\t has floor? "
    #lol += @floor ? "N\n" : "Y\n"
    #lol += "\t has fringe? "
    #lol += @fringe ? "N\n" : "Y\n"
    return lol
  end
  
  def menu_options
    return @actor.menu_options if @actor && @actor.respond_to?("menu_options")
    return @fringe.menu_options if @fringe && @fringe.respond_to?("menu_options")
    return @filling.menu_options if @filling && @filling.respond_to?("menu_options")
    return @floor.menu_options if @floor && @floor.respond_to?("menu_options")
    return false
  end
  
  def self.generate(x, y, floor)
    instance = self.create(:x => x*20, :y => y*20)
    instance.add_floor floor
    return instance
    
    
  end
  
  def what_to_perform_task_on?(task)
    return @actor.menu_options if @actor && @actor.respond_to?("menu_options")
    return @fringe.menu_options if @fringe && @fringe.respond_to?("menu_options")
    return @filling.menu_options if @filling && @filling.respond_to?("menu_options")
    return @floor.menu_options if @floor && @floor.respond_to?("menu_options")
    return false
  end
  
  def next_to?(ablock)
    neighbours = self.all_blocks.blocks_next_to(self)
    #puts "grabbing neighbours: #{neighbours.size}"
    neighbours.each do |n|
      return true if n.same_place_as?(ablock) 
      
    end
    return false
  end
  
  def same_place_as?(ablock)
    return true if (ablock.x == self.x) && (ablock.y == self.y)
    return false
  end
  
  def passable_neighbours
    return self.all_blocks.passable_blocks_next_to(self).dup # dup
    
  end
  
  def guess_distance(tx, ty)
    #puts "guess_distance called!"
    nx = self.x/20
    ny = self.y/20
    distance_guess = Math.sqrt(((tx-nx)**2)+((ty-ny)**2)) # sup pythagarus
    return distance_guess
    
  end
end
