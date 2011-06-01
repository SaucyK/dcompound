
# World

class World < Chingu::GameState
  traits :viewport, :timer

  
  def setup

    
    self.viewport.lag = 0                           # 0 = no lag, 0.99 = a lot of lag.
    self.viewport.game_area = [0, 0, 600, 600]    # Viewport restrictions, full "game world/map/area"
    
    @gg = GameGrid.new
    @gg.setup(100, 100)
    @worker = Worker.create(:x => 200, :y => 200, :image => Image["worker1.png"])
    
    
    @cursor = MapCursor.create(:x => 400, :y => 300, :image => Image["cursor.png"])
    
    every(5000) { self.viewport.center_around (@cursor) }


    super
  end
  
  def update
    @worker.set_target(@cursor.get_target) if @cursor.target_available? == true
    super
  end
  
  def draw

    @gg.draw
    super
  end
  
  
  
end