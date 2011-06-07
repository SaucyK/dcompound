#AStar PriorityQueue
#by Marcin Coles
#27/Sep/2007
#note - not really a priority queue at this point



class NodeQueue
  def initialize(nodes=[])
    @nodes=nodes
    #tie-breaker multiplier (tbmul) is 1+1/(the sqrt of the map size)
    @tbmul=1+1/(Math.sqrt(@nodes.size))
  end
  def method_missing(methodname, *args)
    #if in doubt, act like an array
    @nodes.send(methodname, *args)
  end
  def find_best
    #finds the best node, then pops it out
    best=@nodes.first
    @nodes.each do |node|
      if node.better?(best,@tbmul) then best=node end
    end
    remove(best)
  end
  def find(node)
    #finds a node - requires that node implements ==
    @nodes.find {|x| x==node }
  end
  
  def remove(node)
    #removes a node
    @nodes.delete(find(node))
  end
  
  def to_s
    output=""
    @nodes.each {|e| output<<"#{e};"}
  end
  
end

