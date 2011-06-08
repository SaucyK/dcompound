class TaskList
  attr_accessor :tasks, :world
  def initialize
    @tasks = Array.new
  end
  
  def add_task(task)
    if task.target.class.name == "Array"
      puts "task is an Array! oh noes"
      task.target.each do |t|
        new_task = task.action.new
        new_task.action = task.action
        new_task.title = task.title
        new_task.target = t
        new_task.target.selected = true if new_task.target.respond_to?("selected?")
        new_task.parent = self
        @tasks.push new_task
        puts "added task: #{new_task.title}"
        
        
      end
    else
      new_task = task.action.new
      new_task.action = task.action
      new_task.title = task.title
      new_task.target = task.target
      new_task.target.selected = true if new_task.target.respond_to?("selected?")
      new_task.parent = self
      @tasks.push new_task
      puts "added task: #{new_task.title}"
    end

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