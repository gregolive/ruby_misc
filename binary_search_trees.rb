# frozen_string_literal: true

# Add a new node to the tree
class Node
  include Comparable

  attr_accessor :left, :right
  attr_reader :data

  def initialize(data)
    @data = data
    @left = @right = nil
  end
end

class Tree
  attr_reader :array, :size

  def initialize(array)
    @array = array.uniq.sort
    @size = array.length
    @root = build_tree
  end

  def build_tree(array = @array, start = 0, finish = @size - 1)
    return if start > finish

    mid = (start + finish) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, start, mid-1)
    root.right = build_tree(array, mid+1, finish)
    return root
  end

  def draw_tree(node = @root, prefix = '', is_left = true)
    draw_tree(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    draw_tree(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, cur = @root, prev = nil)
    if cur.nil?
      @size += 1
      return data < prev.data ? prev.left = Node.new(data) : prev.right = Node.new(data)
    end

    if data < cur.data
      insert(data, cur.left, cur)
    else
      insert(data, cur.right, cur)
    end
  end
end

my_tree = Tree.new([1,3,4,6,7,8,9])
puts my_tree.draw_tree

p my_tree.insert(2)
puts my_tree.draw_tree
