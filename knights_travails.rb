class KnightTree
  attr_accessor :shortest_path

  def initialize
    @MOVES = [[2,1],[2,-1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]
    @queue = []
    @start
    @finish
  end

  def get_shortest_path(start, finish)
    @start = Node.new(start, nil)
    @finish = finish
    return build_possibilities
  end

  private

  def build_possibilities
    current = @start
    path = nil
    while path.nil?
      @MOVES.each do |move|
        position = [current.position[0] + move[0], current.position[1] + move[1]]
        unless position[0] < 0 || position[1] < 0
          new_node = Node.new(position, current)
          current.children << new_node
          @queue << new_node
          if position == @finish
            path = get_path_from_child_to_root(new_node)
          end
        end
      end
      current = @queue.shift
    end
    path

  end

  def get_path_from_child_to_root(child)
    path = []
    current = child
    loop do
      path.unshift(current.position)
      if current.parent.nil?
        return path
      else
        current = current.parent
      end
    end
  end

end

class Node
  attr_accessor :position, :parent, :children

  def initialize(position, parent)
    @position = position
    @parent = parent
    @children = []
  end

end

def knight_moves(start, finish)
  knight = KnightTree.new
  path = knight.get_shortest_path(start, finish)
  puts "You made it in #{path.length - 1} moves! Here's your path:"
  until path.empty?
    p path.shift
  end
end

# Example usage:
knight_moves([3,3], [4,3])