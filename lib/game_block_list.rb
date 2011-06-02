class GameBlockList < GameObjectList
  def block_at(coords)
    # coords = [x,y]
    
    @game_objects.each do |o|
      return o if o.block_coords == coords
      
    end
    
  end
  
  
end