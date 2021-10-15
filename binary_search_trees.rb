# frozen_string_literal: true

# Add a new node to the tree
class Node
  include Comparable

  attr_accessor :data, :left, :right

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
    elsif data > cur.data
      insert(data, cur.right, cur)
    end
    return cur
  end

  def delete(data, cur = @root, prev = nil)
    return cur if cur.nil?

    if data < cur.data
      delete(data, cur.left, cur)
    elsif data > cur.data
      delete(data, cur.right, cur)
    else
      # delete node with one or no children
      if cur.left.nil?
        data < prev.data ? prev.left = cur.right : prev.right = cur.right
      elsif cur.right.nil?
        data < prev.data ? prev.left = cur.left : prev.right = cur.left
      else
        # delete node with two children
        replacement = node_min_child(cur.right)
        cur.data = replacement.data
        delete(replacement.data, cur.right)
      end
    end
  end

  def node_min_child(node = @root)
    cur = node
    until cur.left.nil?
      cur = cur.left
    end
    return cur
  end
end

my_tree = Tree.new([1,3,4,6,7,8,9])
puts my_tree.draw_tree

my_tree.insert(0.5)
puts my_tree.draw_tree

my_tree.delete(6)
puts my_tree.draw_tree
