require 'rubygems'
require 'bundler/setup'
Bundler.require
include Gosu
include Chingu
ROOT_PATH = File.dirname(File.expand_path(__FILE__))

require ROOT_PATH + "/lib/context_menu" 
require ROOT_PATH + "/lib/context_menu_option"
require ROOT_PATH + "/lib/selection"
require ROOT_PATH + '/lib/world'

require ROOT_PATH + "/lib/game_block_list" 
require ROOT_PATH + '/lib/game_grid'


require ROOT_PATH + '/lib/tile'
require ROOT_PATH + '/lib/storage'
require ROOT_PATH + '/lib/tree'
require ROOT_PATH + '/lib/wall'
require ROOT_PATH + '/lib/map_cursor'
require ROOT_PATH + '/lib/path_find' # for  a_star
require ROOT_PATH + '/lib/worker'
require ROOT_PATH + '/lib/node' # for a-star
require ROOT_PATH + '/lib/node_queue' # for a-star
require ROOT_PATH + "/lib/game_block" 
require ROOT_PATH + "/lib/task_list"
require ROOT_PATH + "/lib/task"
require ROOT_PATH + "/lib/skill"
require ROOT_PATH + '/lib/resource'
require ROOT_PATH + '/lib/resources/wood'
require ROOT_PATH + '/lib/tasks/chop'
require ROOT_PATH + '/lib/tasks/till'
require ROOT_PATH + '/lib/tasks/build_storage'

GAME_X_SIZE = 100
GAME_Y_SIZE = 100

class Game < Chingu::Window
  
  def initialize
    super 880,580
    self.caption = "Drug Compound"
    self.input = {:escape => :exit}
    #retrofy
    assets_path = File.join(ROOT_PATH, "assets", "default")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","tiles")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","tiles","resources")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","workers")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","ui")
    Gosu::Song.autoload_dirs << File.join(assets_path, "music")
    switch_game_state(World)
    
  end
  
  
  def update

    super
  end
  
  def draw

    super
  end
  
  
end







Game.new.show