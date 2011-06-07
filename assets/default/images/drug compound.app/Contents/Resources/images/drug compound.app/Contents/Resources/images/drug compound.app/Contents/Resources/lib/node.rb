module Node

    #class Node provides a node on a map which can be used for pathfinding. 
    #For Node to work with PriorityQueue and AMap it needs to implement the following
    # <= used for comparing g values
    # == used for finding the same node - using the x,y co-ordinates
    attr_accessor :parent, :g
    attr_reader :x,:y,:h,:m
    
    #def initialize(x,y,move_cost=0)
    #  @x,@y,@m=x,y,move_cost
    #  @g=@m
    #  @h=0
    #end
    
    def node_to_s
      #prints the node in the following format [x,y] f:g:h
      out = ""
      out += "[#{@x/20},#{@y/20}] #{@g+@h}:#{@g}:#{@h}\n"
      p = self.parent
      while p.class.name == "GameBlock"
        out += p.node_to_s
        p = p.parent
      end
      
      return out
    end
    
    def <=>(other)
      #can be used for ordering the priority list
      #puts "using <=>" #currently unused - can delete this line if required
      self.f<=>other.f
    end
    
    def <=(other)
      #used for comparing cost so far
      @g<=other.g
    end
     
    def same_as?(other)
      # nodes are == if x and y are the same - used for finding and removing same node
      return false if other==nil
      return ((@x/20)==(other.x/20))&((@y/20)==(other.y/20))
    end
    
    def calc_g(previous)
      #cost so far is total cost of previous step plus the movement cost of this one
      @g=previous.g+10
    end
    
    def calc_h(goal)
      #using manhattan distance to generate a heuristic value
      @h=((@x/20)-(goal.x/20)).abs+((@y/20)-(goal.y/20)).abs
    end
    def f
      @g+@h
    end
    def better?(other,tbmul=1.01)
      #which is better, self or other
      #can pass a tie-breaker multiplier (tbmul) if required
      if other==nil then return false end
      if self==other then return false end
      if f<other.f then 
        return true
      #here's the tie-breaker
      elsif f==other.f then
        nf=@g+tbmul*@h
        bf=other.g+tbmul*other.h
        if nf<bf then return true end
      end
      false
    end
      
    
end