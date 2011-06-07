class Resource < GameObject
  attr_accessor :type, :value, :weight, :block
  
  
  def add_to_block(block)
    @block = block
    @block.add_fringe(self)
  end
end