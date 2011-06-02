require 'rubygems'
require 'bundler/setup'
Bundler.require
include Gosu
include Chingu
ROOT_PATH = File.dirname(File.expand_path(__FILE__))

require ROOT_PATH + '/lib/world'
require ROOT_PATH + '/lib/game_grid'
require ROOT_PATH + '/lib/tile'
require ROOT_PATH + '/lib/map_cursor'
require ROOT_PATH + '/lib/worker'
require ROOT_PATH + "/lib/game_block" 


class Game < Chingu::Window
  
  def initialize
    super 900,600
    self.caption = "Drug Compound"
    self.input = {:escape => :exit}
    retrofy
    assets_path = File.join(ROOT_PATH, "assets", "default")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","tiles")
    Gosu::Image.autoload_dirs << File.join(assets_path, "images","workers")
    
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