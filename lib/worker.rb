class Worker < GameObject

  
  def setup
    @has_task = false
    
  end
  
  def set_target(coords)
    puts "ooh, a job! I'm going to [#{coords[0]},#{coords[1]}] from [#{@x},#{@y}]"
    @target_x = coords[0]
    @target_y = coords[1]
    @has_task = true
  end
  
  def update
    unless @has_task == false
 
      if @target_x > @x
        @x += 20
        puts "moving right"
      end
      if @target_x < @x
        @x -= 20
        puts "moving left"
      end
      
      if @target_y > @y
        @y += 20
        puts "moving down"
      end
      
      if @target_y < @y
        @y -= 20
        puts "moving up"
      end
      
      if @target_x == @x && @target_y == @y
        @has_task = false
        puts "i ahve arrived"
      end
      
    end
    
    
  end
  
end