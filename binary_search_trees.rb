# frozen_string_literal: true

# Add a new node to the tree
class Node
  include Comparable

  attr_accessor :left_child, :right_child
  attr_reader :data

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

class Tree

  def initialize(array)
    @array = array.uniq
    @root = nil
  end

  def build_tree

  end
end

array = []
10.times { |num|
  array.push(Node.new(num))
  num += 1
}
Tree.new(array)

p array