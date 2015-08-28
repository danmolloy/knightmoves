class Node
  attr_accessor(:coordinates, :links, :explored, :distance)

  def initialize(coordinates)
    @coordinates = coordinates
    @links = []
    @explored = false
  end

  def explored?
    @explored
  end

  def inspect
    "Node(#{@coordinates})"
  end

  def link(coordinates)
    @links << coordinates
  end

end

class KnightGraph

  attr_reader(:nodes)

  def initialize

    create_nodes
    link_nodes

  end

  def create_nodes
    @nodes = Hash.new
    row = 8
    8.times do
      column = 'a'
      8.times do
        position = (column + row.to_s).to_sym
        @nodes[position] = Node.new(position.to_s)
        column.next!
      end
      row -= 1
    end
  end

  def link_nodes

    @nodes.each_value do |node|
      candidates = []

      coordinates = node.coordinates.chars
      coordinates[0] = coordinates[0].ord
      coordinates[1] = coordinates[1].to_i
      n = coordinates[0]
      m = coordinates[1]
      a = n + 2
      b = m + 1
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n - 2
      b = m + 1
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n + 2
      b = m - 1
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n - 2
      b = m - 1
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n + 1
      b = m + 2
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n + 1
      b = m - 2
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n - 1
      b = m + 2
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)
      a = n - 1
      b = m - 2
      candidates << a.chr + b.to_s if a.between?(97, 104) && b.between?(1, 8)

      candidates.each do |candidate|
        node.link(candidate)
      end
    end

    # @nodes.each_value do |node|
    #   puts "square:#{node.coordinates}, links:
    #   #{node.links}, explored: #{node.explored?}"
    # end
    # p @nodes[:a1].coordinates.class
  end


end
