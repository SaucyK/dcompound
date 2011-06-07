class Chop < Task

  def perform_task
    skill_power = self.assignee.skill_at(Chop)
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
    @target.destroy
    wood = Wood.generate(block)
    block.add_fringe(wood)
  end
end