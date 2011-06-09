class BuildStorage < Task
  def perform_task
    skill_power = self.assignee.skill_at(BuildStorage)
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
    @target.block.add_floor(Storage.new(:x => block.x, :y => block.y, :image => Image["storage1.png"]))
    @target.block.function = :storage
  end
  
end