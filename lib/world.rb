
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
    
    
      every(120000) { @gg.timed_tree_growth }
      super
    end
  end
  
  def update
    #@gg.update

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
      @menu = ContextMenu.new
      @menu.add_options Tree.menu_options()
      push_game_state @menu
    end
    
  end
  
end