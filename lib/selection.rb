class Selection < GameObject
  attr_accessor :corner1, :corner2, :blocks, :display
  
  
  
  
  def blocks_in?
    
  end
  
  def in_selection?(coords)
    ax = coords[0]*20
    ay = coords[1]*20
    @blocks.each do |b|
      return true if (b.x==ax) && (b.y==ay)
    end
    return false 
  end
  
  def menu_options #do this next
    options = []
    handled_actions = []
    types = {}
    @blocks.each do |b|
      options_from_block = b.menu_options
      unless options_from_block == false || options_from_block.nil?
        options_from_block.each do |opt|
          #ContextMenuOption.generate("icon_axe.png", "Chop Tree",:target => self, :action => Chop)
          unless opt == false
            unless opt.action == "cancel"
              if types[opt.action.name.to_sym]
                types[opt.action.name.to_sym] << opt.target unless types[opt.action.name.to_sym].include? opt.target
              else
                types[opt.action.name.to_sym] = [opt.target]
              end
              opt.target = nil
            end
            #new_opt = ContextMenuOption.new(:image => opt.image, :action => opt.action, :target => self)
            
            options << opt unless options.include?(opt) unless handled_actions.include?(opt.action)
            handled_actions << opt.action unless handled_actions.include?(opt.action)
          end
        end
      end
    end
    options.each do |o|
      
      o.target = types[o.action.name.to_sym] unless o.action == "cancel"
    end
    #reassess targets
    return options
  end
  
  def clear_selection
    unless @display.nil?
      @display.each do |d|
        d.destroy! unless d.nil?
      end
    else
      @blocks = nil
      @corner1 = nil
      @corner2 = nil
      
    end
  end
  
  def delete
    
  end
  
  def draw
    @display.each do |d|
      d.draw
    end
  end
  
  def process(all_blocks)
    #retrieve all blocks between the corners
    @blocks = []
    @display = []
    if @corner1.x > @corner2.x
      dxp = -20
      dx = -1
    else
      dxp = 20
      dx = 1
    end
    if @corner1.y > @corner2.y
      dyp = -20
      dy = -1
    else
      dyp = 20
      dy = 1
    end
    
    rows = ((@corner1.x-@corner2.x).abs/20)
    cols = ((@corner1.y-@corner2.y).abs/20)
    
    newx = @corner1.x
    newy = @corner1.y
    #puts "finding all blocks between [#{@corner1.x},#{@corner1.y}] & [#{@corner2.x},#{@corner2.y}] in increments of #{dx},#{dy}"
    rc = 0 #row count
    cc = 0 #col count
    while (rc <= rows) do
      #puts "looking for blocks in #{rc*20} out of #{rows}"
      while(cc <= cols) do
        #puts "looking for a block in #{newx},#{newy}"
        b = all_blocks.block_at([newx/20,newy/20])
        @blocks << b
        #puts "adding block to selection #{b}"
        newy += dyp
        @display << GameObject.create(:x => b.x, :y => b.y, :image => Image["selection.png"])
        cc += 1
      end
      rc += 1
      cc = 0
      newy = @corner1.y
      newx += dxp
    end
  
  
    #puts "there are #{@blocks.size} blocks found"
  end
  
  
end