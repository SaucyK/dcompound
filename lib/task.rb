class Task
  attr_accessor :title, :icon, :action, :target, :assignee, :progress, :parent
  
  def initialize
    @progress = 0.0
    
  end
  
  def add_successor_task(task)
    self.parent.add_task(task)
  end
  
end