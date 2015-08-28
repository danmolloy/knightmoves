require "./knightmoves_graph.rb"

class KnightBFS

  def initialize(start, target)
    @graph = KnightGraph.new
    # use push/shift only for q
    @path = []
    @q = []
    @start_node = @graph.nodes[start.to_sym]
    @target_node = @graph.nodes[target.to_sym]
    find_distances
  end


  def find_distances

    @start_node.explored = true
    @start_node.distance = 0
    @q.push(@start_node)

    while @q.length != 0
      current_node = @q.shift

      current_node.links.each do |link|
        candidate_node = @graph.nodes[link.to_sym]
        if candidate_node.explored? == false
          explore(current_node, candidate_node)
        end
      end
    end

    create_path(@target_node)
    puts "distance from #{@start_node.coordinates} to #{@target_node.coordinates}: #{@target_node.distance}"
    puts "path: #{@path}"
  end

  def explore(explorer, node)
    node.explored = true
    node.distance = explorer.distance + 1
    @q.push(node)
  end

  def create_path(current_node)
    return if @path[0] == @start_node.coordinates
    next_node = nil

    @path.unshift(current_node.coordinates)
    current_node.links.each do |link|
      candidate_node = @graph.nodes[link.to_sym]
      if candidate_node.distance == current_node.distance - 1
        next_node = candidate_node
        break
      end
    end
    create_path(next_node)
  end
end

# 10.times do
#   start = rand(97..104).chr + rand(1..8).to_s
#   target = rand(97..104).chr + rand(1..8).to_s
#   KnightBFS.new(start, target)
#
# end

test = KnightBFS.new(ARGV[0], ARGV[1])
