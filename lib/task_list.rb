class TaskList
  attr_accessor :tasks
  def initialize
    @tasks = Array.new
  end
  
  def add_task(task)
    new_task = task.action.new
    new_task.action = task.action
    new_task.title = task.title
    new_task.target = task.target
    @tasks.push new_task
    puts "added task: #{new_task.title}"
  end
  
  def get_task
    unless @tasks[0].nil?
      task = @tasks[0]
      @tasks.delete_at(0)
      return task
    else
      return false
    end
  end
  
  def return_task(task)
    @tasks.push task
  end
  
  def task_available?
    return true if @tasks.size > 0
    return false
  end
end