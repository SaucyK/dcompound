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
  
  
  def blocks_next_to block
    bx = block.x/20
    by = block.y/20
    ab = Array.new
    
    # top left
    unless bx <= 0 && by <= 0
      ab << self.block_at([bx-1,by-1]) unless self.block_at([bx-1,by-1]).nil? || ab.include?(self.block_at([bx-1,by-1]).nil?)
    end  
    
    # top center
    unless by <= 0 
      ab << self.block_at([bx,by-1]) unless self.block_at([bx,by-1]).nil? || ab.include?(self.block_at([bx,by-1]).nil?)
    end
    
    # top right
    unless by <= 0 and bx >= GAME_X_SIZE
      ab << self.block_at([bx+1,by-1]) unless self.block_at([bx+1,by-1]).nil? || ab.include?(self.block_at([bx+1,by-1]).nil?)
    end
    
    # center right
    unless bx >= GAME_X_SIZE
      ab << self.block_at([bx+1,by]) unless self.block_at([bx+1,by]).nil? || ab.include?( self.block_at([bx+1,by]).nil?)
    end
    
    # bottom right
    unless by >= GAME_Y_SIZE &&  bx >= GAME_Y_SIZE
      ab << self.block_at([bx+1,by+1]) unless self.block_at([bx+1,by+1]).nil? || ab.include?( self.block_at([bx+1,by+1]).nil?)
    end
    
    # bottom center
    unless by >= GAME_Y_SIZE
      ab << self.block_at([bx,by+1]) unless self.block_at([bx,by+1]).nil? || ab.include?( self.block_at([bx,by+1]).nil?)
    end
    
    # bottom left
    unless by >= GAME_Y_SIZE && bx <= 0
      ab << self.block_at([bx-1,by+1]) unless self.block_at([bx-1,by+1]).nil? || ab.include?( self.block_at([bx-1,by+1]).nil?)
    end
    
    # center left
    unless bx <= 0
      ab << self.block_at([bx-1,by]) unless self.block_at([bx-1,by]).nil? || ab.include?( self.block_at([bx-1,by]).nil?)
    end
    
    #puts "sending back adjacent blocks: #{ab.size} items"
    return ab
  end
  
  def passable_blocks_next_to block
    bx = block.x/20
    by = block.y/20
    ab = Array.new
    
    
    # top left
    #unless bx <= 0 && by <= 0
    #  ab << self.block_at([bx-1,by-1]) unless self.block_at([bx-1,by-1]).nil? || ab.include?(self.block_at([bx-1,by-1]).nil?) || !self.block_at([bx-1,by-1]).passable?
    #end  
    
    # top center
    unless by <= 0 
      ab << self.block_at([bx,by-1]) unless self.block_at([bx,by-1]).nil? || ab.include?(self.block_at([bx,by-1]).nil?) || !self.block_at([bx,by-1]).passable?
    end
    
    # top right
    #unless by <= 0 and bx >= GAME_X_SIZE
    #  ab << self.block_at([bx+1,by-1]) unless self.block_at([bx+1,by-1]).nil? || ab.include?(self.block_at([bx+1,by-1]).nil?) || !self.block_at([bx+1,by-1]).passable?
   # end
    
    # center right
    unless bx >= GAME_X_SIZE
      ab << self.block_at([bx+1,by]) unless self.block_at([bx+1,by]).nil? || ab.include?( self.block_at([bx+1,by]).nil?) || !self.block_at([bx+1,by]).passable?
    end
    
    # bottom right
   # unless by >= GAME_Y_SIZE &&  bx >= GAME_Y_SIZE
    #  ab << self.block_at([bx+1,by+1]) unless self.block_at([bx+1,by+1]).nil? || ab.include?( self.block_at([bx+1,by+1]).nil?) || !self.block_at([bx+1,by+1]).passable?
   # end
    
    # bottom center
    unless by >= GAME_Y_SIZE
      ab << self.block_at([bx,by+1]) unless self.block_at([bx,by+1]).nil? || ab.include?( self.block_at([bx,by+1]).nil?) || !self.block_at([bx,by+1]).passable?
    end
    
  #  # bottom left
   # unless by >= GAME_Y_SIZE && bx <= 0
   #   ab << self.block_at([bx-1,by+1]) unless self.block_at([bx-1,by+1]).nil? || ab.include?( self.block_at([bx-1,by+1]).nil?) || !self.block_at([bx-1,by+1]).passable?
   # end
    
    # center left
    unless bx <= 0
      ab << self.block_at([bx-1,by]) unless self.block_at([bx-1,by]).nil? || ab.include?( self.block_at([bx-1,by]).nil?) || !self.block_at([bx-1,by]).passable?
    end
    
    #puts "sending back adjacent blocks: #{ab.size} items"
    return ab
  end
  
  
  def reset_path_find
    @block_holder.each do |holder|
      b = holder[1]
      b.closed = false if b.closed
      b.d = nil if !b.d.nil?
      
    end
  end
end