require 'fiber'
# World

class World < Chingu::GameState
  traits :viewport, :timer
  
  
  def setup

    if(@menu)
      @menu = nil
      
    else #no menu
      self.viewport.lag = 0.99                           # 0 = no lag, 0.99 = a lot of lag.
      self.viewport.game_area = [10, 10, GAME_X_SIZE * 20, GAME_Y_SIZE * 20]    # Viewport restrictions, full "game world/map/area"
    
      @gg = GameGrid.new
      @gg.setup(GAME_X_SIZE, GAME_Y_SIZE)
      #@worker = 
    
    
     # @cursor = 
    
      @gg.add_cursor()
      
      5.times do |num|
        x = 5 + num
        y = 5 + num
        
        @gg.add_worker(x,y)
      end
      
      @music = Song["chilled1.mp3"]
    

      self.input = {
        :m => :toggle_music,
        :a => :show_menu,
        :lshift => :handle_selection
      }
    
      #menu
      
      @all_tasks = TaskList.new
      @debug_text = Chingu::Text.new('', :size => 20)
      @debug_text.x = 30
      @debug_text.y = 30
      every(120000) { @gg.timed_tree_growth }
      every(500) {@gg.update_workers}
      super
    end
  end
  
  def update
    #@gg.update
    @debug_text.text = @gg.block_at(@gg.cursor.block_coords()).to_s
    #@worker.set_target(@cursor.get_target) if @cursor.target_available? == true
    if @menu
      @menu.update if @menu
    else
      @gg.update
      self.viewport.center_around (@gg.cursor)
    end
    
    #assign tasks if available
    if @all_tasks.task_available? 
      @all_tasks.tasks.each do |task|
        @gg.all_workers.each do |worker|
          if worker.needs_task?
            #puts "assigning task to worker"
            new_task = @all_tasks.get_task
            worker.add_task(new_task) unless new_task == false
            break
          end
      
        end #each worker
      end #task available
    end
    
  
    
    super
  end
  
  def handle_selection
    unless @selection.nil?
      block = @gg.block_at(@gg.cursor.block_coords())
      if @selection.corner2.nil? #select 2nd point
        @selection.corner2 = block
        @selection.process(@gg.all_blocks)
      else #start new selection
        @selection.clear_selection
        @selection.destroy!
        block = @gg.block_at(@gg.cursor.block_coords())
        @selection = Selection.new
        @selection.corner1 = block
      end
    else
      block = @gg.block_at(@gg.cursor.block_coords())
      @selection = Selection.new
      @selection.corner1 = block
    end
  end
  
  def draw
    #if @menu
    #  @menu.draw
    #else
      @gg.draw
      @debug_text.draw
      
      if !@selection.nil? && !@selection.blocks.nil? && @selection.blocks.size > 0
        @selection.draw
      end
    #end
    #@gg.draw
    #@menu.draw if @menu
    super
  end
  
  def toggle_music
    if @music.playing?
        @music.pause
      else
        @music.play(true)
      end
  end
  
  def show_menu
    unless @menu
      if @selection && @selection.corner2 && @selection.in_selection?(@gg.cursor.block_coords)
        
        options = @selection.menu_options
      else
        options = @gg.block_at(@gg.cursor.block_coords()).menu_options
        #if @selection
          @selection.corner1 = nil
          @selection.corner2 = nil
          @selection.clear_selection
          @selection.destroy!
          @selection = nil
        #end
      end
      
      unless options == false || options.nil? || options.size <= 0
        @menu = ContextMenu.new
        @menu.add_options options
        @menu.holder = self
        push_game_state @menu if @menu.menu_options.size > 0
      end
    end
    
  end
  
  def add_task_from_menu(task)
    @all_tasks.add_task task
    if @selection
      @selection.clear_selection
      @selection.destroy!
    end
    
  end
  
end