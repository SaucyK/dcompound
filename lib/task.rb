class Task
  attr_accessor :title, :icon, :action, :target, :assignee, :progress, :parent
  
  def initialize
    @progress = 0.0
    
  end
  
end