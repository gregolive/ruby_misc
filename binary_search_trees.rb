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
  attr_reader :array

  def initialize(array)
    @array = array.uniq
    @root = build_tree
  end

  def build_tree(array = @array, start = 0, finish = array.length - 1)
    return if start > finish

    mid = (start + finish) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, start, mid-1)
    root.right_child = build_tree(array, mid+1, finish)
    return root
  end

  def draw_tree(node = @root, prefix = '', is_left = true)
    draw_tree(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    draw_tree(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

my_tree = Tree.new([1,2,3,4,5,6,7,8,9])
my_tree.build_tree
puts my_tree.draw_tree