class Till < Task
  def perform_task
    skill_power = self.assignee.skill_at(Till)
    @progress += skill_power
    #puts "chopping wood. chopped #{skill_power} out for total of #{@progress}"
    if @progress >= 100
      task_complete
      return true
    else
      return false
    end  
  end
  
  
  def task_complete
    block = @target.block
    
    @target.selected = false
    @target.block.add_floor(Tile.new(:x => block.x, :y => block.y, :image => Image["farm1.png"]))
    @target.block.function = :farm
  end
  
end