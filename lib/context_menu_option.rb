class ContextMenuOption < GameObject
  attr_accessor :title, :icon, :action, :target
  
  def setup
    
  end
  
  
  def self.generate(image, title, options = {})
    puts "generating option"

    o = ContextMenuOption.new(:image => image)
    unless options[:target]
      o.target = "cancel"
    else
      o.target = options[:target]
    end
    
    unless options[:action]
      o.action = "cancel" 
    else
      o.action = options[:action]
    end
    o.title = title
    
    return o
  end
  
end