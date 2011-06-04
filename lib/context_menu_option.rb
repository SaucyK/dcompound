class ContextMenuOption < GameObject
  attr_accessor :title, :icon, :action
  
  def setup
    
  end
  
  
  def self.generate(image, title)
    puts "generating option"
    o = ContextMenuOption.new(:image => image)
    o.title = title
    
    return o
  end
  
end