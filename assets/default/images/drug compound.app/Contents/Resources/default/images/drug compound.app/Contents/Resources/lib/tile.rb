
# Tile

class Tile < Chingu::GameObject
  

  def setup

  end
  
  def draw
    
    super
  end
  
  def block_coords
     return [self.x/20,self.y/20]
   end
  
  def self.generate_new(x,y,terrain)
    id = 1 + rand(3) 
    terrain_image = terrain+id.to_s+".png"
    
    instance = self.create(:image => Image[terrain_image], :x => x*20, :y => y*20)
    
    return instance

  end
end