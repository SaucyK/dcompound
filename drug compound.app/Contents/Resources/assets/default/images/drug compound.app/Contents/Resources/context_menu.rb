class ContextMenu < Chingu::GameState
  attr_accessor :radius, :pointer, :menu_options, :holder

  
  def initialize
    super
    self.input = {
      :x => :close_menu,
      :space => :select,
      :q => :turn_left,
      :e => :turn_right
    }
    
    @center_x = $window.width/2
    @center_y = $window.height/2
    
    @radius = 100
    
    @selected_item_name = Chingu::Text.new('', :size => 25)
    @selected_item_name.x =  @center_x - (@radius/2)
    @selected_item_name.y = @center_y
    @menu_options = ContextMenuArray.new
    
    @bg = GameObject.create(:x => @center_x, :y => @center_y, :image => Image["bg_menu.png"])
    @cursor = GameObject.create(:image => Image["menu_cursor.png"])
    

  end
  
  def close_menu
    reset_options
    
    pop_game_state(:transistional => false)
    
  end
  
  def reset_options
    @menu_options = ContextMenuArray.new
  end
  

  def update
    #puts "updating menu"
    close_menu unless @menu_options.size > 0
    #puts "menu not closed"
    angle = (360 / @menu_options.size-1)

      rad = angle * (Math::PI/180)
      @cursor.x = @center_x
      @cursor.y = @center_y - @radius
      
      @cursor.x = @center_x + (@radius * Math.sin(rad)).round
      @cursor.y = @center_y + (@radius * Math.cos(rad)).round
    
    
 
    @menu_options.each_with_index do |o,index|
      i = index+1
        target_angle = (i * angle) * (Math::PI/180)
        o.x = @center_x + (@radius * Math.sin(target_angle)).round
        o.y = @center_y + (@radius * Math.cos(target_angle)).round
    end

    #super
    
    @selected_item_name.text = @menu_options.first.title
  end
  
  def draw
    #puts "drawing menu"
    previous_game_state.draw
    $window.flush
    @bg.draw
    
    @menu_options.each do |o|
      o.draw
      #puts "drew option"
    end  
    @cursor.draw
    @selected_item_name.draw
    #super  
  end
  
  
  def show
    
  end
  
  def add_options(new_options)
    #puts "adding options to menu"
    return false if new_options == false
    
    new_options.each do |o| 
      @menu_options << o
      #puts "added option to menu"
    end
  end
  
  def select
    unless @menu_options.first.action == "cancel"
      @holder.add_task_from_menu @menu_options.first
    end
    
    close_menu
  end
  
  def turn_left 
    #puts "turning left"
    @menu_options.rotate! +1

    @selected_item_name.text = @menu_options.first.title
  end
  
  def turn_right
    #puts "turning right"
    @menu_options.rotate! -1

    @selected_item_name.text = @menu_options.first.title
  end
end


class ContextMenuArray < Array
  
  def rotate!(key = 1)
  
    if key >= 0 then push    *shift(key)
    else           unshift *pop(-key)
    end
  
  end
  
  
end