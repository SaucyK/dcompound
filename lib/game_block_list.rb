class GameBlockList < GameObjectList
  def block_at(coords)
    # coords = [x,y]
    
    key = coords[0].to_s+"_"+coords[1].to_s
    return @block_holder[key]
    
  end
  
  def setup(xsize, ysize)
    @xsize = xsize
    @ysize = ysize
    
    @block_holder  = Hash.new
  end
  
  def add_block(block)
    self.add_game_object(block)
    key = (block.x/20).to_s+"_"+(block.y/20).to_s
    #puts "Added block at #{key}"
    @block_holder[key] = block
  end
  
  
  
  
end