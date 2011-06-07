class Wood < Resource
  
  def draw

    super
  end
  
  def self.generate(ablock)
    

    @image = Image["wood1.png"]
    wood = Wood.new(:image => @image, :x => ablock.x, :y => ablock.y)
    wood.type = "Wood"
    wood.value = 1.00
    wood.weight = 1.00
    return wood
  end
  
end