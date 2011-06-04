
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
      @gg.add_worker()
      @music = Song["chilled1.mp3"]
    

      self.input = {
        :m => :toggle_music,
        :a => :show_menu
      }
    
      #menu
      
      @all_tasks = TaskList.new
      @debug_text = Chingu::Text.new('', :size => 20)
      @debug_text.x = 30
      @debug_text.y = 30
      every(120000) { @gg.timed_tree_growth }
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
    
    super
  end
  

  
  def draw
    #if @menu
    #  @menu.draw
    #else
      @gg.draw
      @debug_text.draw
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
      
      options = @gg.block_at(@gg.cursor.block_coords()).menu_options
      unless options == false
        @menu = ContextMenu.new
        @menu.add_options options
        @menu.holder = self
        push_game_state @menu if @menu.menu_options.size > 0
      end
    end
    
  end
  
  def add_task_from_menu(task)
    @all_tasks.add_task task
  end
  
end