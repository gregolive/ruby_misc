# frozen_string_literal: true

# rubocop:disable Style/MethodLength, Metrics/ClassLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# Balanced BST Data Structure

# Add a new node to the tree
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = @right = nil
  end
end

# Build BST
class Tree
  attr_accessor :array
  attr_reader :size

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree
  end

  def build_tree(array = @array, start = 0, finish = @array.length - 1)
    return if start > finish

    mid = (start + finish) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, finish)
    root
  end

  def draw_tree(node = @root, prefix = '', is_left: true)
    draw_tree(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    draw_tree(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end

  def insert(data, cur = @root, prev = nil)
    if cur.nil?
      @array.push(data)
      return data < prev.data ? prev.left = Node.new(data) : prev.right = Node.new(data)
    end

    if data < cur.data
      insert(data, cur.left, cur)
    elsif data > cur.data
      insert(data, cur.right, cur)
    end
    cur
  end

  def delete(data)
    delete_node(data)
    @array.delete(data)
  end

  def delete_node(data, cur = @root, prev = nil)
    return cur if cur.nil?

    if data < cur.data
      delete_node(data, cur.left, cur)
    elsif data > cur.data
      delete_node(data, cur.right, cur)
    elsif cur.left.nil?
      # delete node with one or no children
      data < prev.data ? prev.left = cur.right : prev.right = cur.right
    elsif cur.right.nil?
      data < prev.data ? prev.left = cur.left : prev.right = cur.left
    else
      # delete node with two children
      replacement = min_in_node(cur.right)
      cur.data = replacement
      delete_node(replacement, cur.right)
    end
    cur
  end

  def min_in_node(node = @root)
    cur = node
    cur = cur.left until cur.left.nil?
    cur.data
  end

  def find(data)
    cur = @root
    cur = cur.data > data ? cur.left : cur.right until cur.nil? || cur.data == data
    cur.nil? ? nil : cur
  end

  def level_order(root = @root, array = [], queue = [root])
    return array if queue.empty?

    unless root.nil?
      array.push(root.data)
      queue.push(root.left).push(root.right)
    end
    queue.delete(root)
    level_order(queue[0], array, queue)
  end

  def preorder(root = @root, array = [])
    return array if root.nil?

    array.push(root.data)
    preorder(root.left, array)
    preorder(root.right, array)
  end

  def inorder(root = @root, array = [])
    return array if root.nil?

    inorder(root.left, array)
    array.push(root.data)
    inorder(root.right, array)
  end

  def postorder(root = @root, array = [])
    return array if root.nil?

    postorder(root.left, array)
    postorder(root.right, array)
    array.push(root.data)
  end

  def depth(target, cur = @root, layers = 0)
    return nil unless find(target)
    return layers if cur.data == target

    layers += 1
    if !cur.left.nil? && target < cur.data
      layers = depth(target, cur.left, layers)
    elsif !cur.right.nil? && target > cur.data
      layers = depth(target, cur.right, layers)
    end
    layers
  end

  def height(node, height = 0)
    node = find(node) if node.is_a? Integer
    return 0 if node.nil?

    left_height = height(node.left, height)
    right_height = height(node.right, height)
    [left_height, right_height].max + 1
  end

  def balanced?
    left = height(@root.left)
    right = height(@root.right)
    (left - right).abs <= 1
  end

  def rebalance
    @array = inorder
    @root = build_tree
  end
end

# Test class methods
def test_tree
  tree = Tree.new(Array.new(15) { rand(1..100) })
  puts tree.draw_tree
  puts "Tree is balanced? #{tree.balanced?}\n\n"

  puts 'Elements in level, pre, post, and in order...'
  p tree.level_order
  p tree.preorder
  p tree.postorder
  p tree.inorder

  puts "\nAdding new elements..."
  Array.new(5) { rand(101..200) }.each { |num| tree.insert(num) }
  puts tree.draw_tree
  puts "Tree is balanced? #{tree.balanced?}\n\n"

  puts "\nRebalancing..."
  tree.rebalance
  puts tree.draw_tree
  puts "Tree is balanced? #{tree.balanced?}\n\n"

  puts 'Elements in level, pre, post, and in order...'
  p tree.level_order
  p tree.preorder
  p tree.postorder
  p tree.inorder
end

test_tree

# rubocop:enable Style/MethodLength, Metrics/ClassLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
