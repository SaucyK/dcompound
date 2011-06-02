
# World

class World < Chingu::GameState
  traits :viewport, :timer

  
  def setup

    
    self.viewport.lag = 0                           # 0 = no lag, 0.99 = a lot of lag.
    self.viewport.game_area = [10, 10, 2000, 2000]    # Viewport restrictions, full "game world/map/area"
    
    @gg = GameGrid.new
    @gg.setup(100, 100)
    @worker = Worker.create(:x => 200, :y => 200, :image => Image["worker1.png"])
    
    
    @cursor = MapCursor.create(:x => 400, :y => 300, :image => Image["cursor.png"])
    
    @music = Song["chilled1.mp3"]
    

    self.input = {
      :m => :toggle_music,
    }
    super
  end
  
  def update
    @worker.set_target(@cursor.get_target) if @cursor.target_available? == true
    self.viewport.center_around (@cursor)
    super
  end
  
  def draw

    @gg.draw
    super
  end
  
  def toggle_music
    if @music.playing?
        @music.pause
      else
        @music.play(true)
      end
  end
  
  
end