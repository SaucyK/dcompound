class Wood < Resource
  
  def self.generate
    @type = "Wood"
    @value = 1.00
    @weight = 1.00
    @image = Image["wood1.png"]
  end
  
end