class TaskList
  def initialize
    @tasks = Array.new
  end
  
  def add_task(task)
    new_task = Task.new
    new_task.action = task.action
    new_task.title = task.title
    new_task.target = task.target
    @tasks << new_task
    puts "added task: #{new_task.title}"
  end
end