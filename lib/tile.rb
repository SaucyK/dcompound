
# Tile

class Tile < Chingu::GameObject
  attr_accessor :block, :selected

  def setup

  end
  def selected?
    return true if @selected == true
    return false
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
  
  def menu_options
    opts = []
    
    opts << ContextMenuOption.generate("icon_storage.png", "Build Storage Area",:target => self, :action => BuildStorage)
    opts << ContextMenuOption.generate("icon_spade.png", "Till Land",:target => self, :action => Till)
    opts << ContextMenuOption.generate("icon_cancel.png","Cancel")
    
    return opts
  end
end