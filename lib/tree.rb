class Tree < GameObject
  
  
  
  
  def self.generate_forest(xsize, ysize)
    
    forest_radius = rand(20)
    start_point = [rand(xsize), rand(ysize)]
    start_point[0] += 1 if start_point[0] == 0
    start_point[1] += 1 if start_point[1] == 0
    grid = []
    trees = GameObjectList.new
    
    (1..forest_size)
      grid[start_point[0]]
  end
end