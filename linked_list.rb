# frozen_string_literal: true

# Display error messages to the console
module DisplayErrors
  # error messages
  def err_empty_list
    "#{@name} is empty!"
  end

  def err_no_entry(index)
    "#{@name} does not contain #{index} entries."
  end
end

# Create a new node in the list
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

# Represents the full linked list
class LinkedList
  include DisplayErrors

  attr_reader :head

  @@entries = 0

  def initialize
    @head = nil
    @tail = nil
  end

  # adds a new node to the end of the list
  def append(value)
    if @head.nil?
      @head = value
      @tail = value
    else
      @tail.next_node = value
      @tail = value
    end
    @@entries += 1
  end

  # adds a new node to the start of the list
  def prepend(value)
    if @head.nil?
      @head = value
      @tail = value
    else
      value.next_node = @head
      @head = value
    end
    @@entries += 1
  end

  # returns the total number of nodes in the list
  def size
    @@entries
  end

  # returns the first node in the list
  def head
    @head.nil? ? err_empty_list : @head.value
  end

  # returns the last node in the list
  def tail
    @head.nil? ? err_empty_list : @tail.value
  end

  # returns the node at the given index
  def at(index)
    return err_no_entry(index) if index < 1 || index > @@entries

    search_for(index).value
  end

  def search_for(index)
    return @head if index == 1

    cur = @head
    index -= 1
    while index > 0
      cur = cur.next_node
      index -= 1
    end
    return cur
  end

  # removes the last element from the list
  def pop
    return err_empty_list if @head.nil?

    if @@entries == 1
      @head = nil
      @tail = nil
    else
      @tail = nil
    end
    @@entries -= 1
  end

  # returns true if the passed in value is in the list
  def contains?(value)
    return err_empty_list if @head.nil?

    find(value).nil? ? false : true
  end

  # returns the index of the node containing value or nil
  def find(value)
    return err_empty_list if @head.nil?

    cur = @head
    index = 1
    while !cur.nil?
      break if cur.value == value
      cur = cur.next_node;
      index += 1
    end
    cur.nil? ? nil : index
  end

  # print list objects as strings
  def to_s
    cur = @head
    output = ""
    count = 0
    while count < @@entries
      output += "( #{cur.value} ) -> "
      cur = cur.next_node
      count += 1
    end
    return output += "nil"
  end
end

my_list = LinkedList.new
value1 = Node.new(30)
value2 = Node.new(20)
value3 = Node.new(10)

my_list.append(value1)
my_list.prepend(value2)
my_list.append(value3)

puts my_list.size
puts my_list.head
puts my_list.at(2)
puts my_list.tail

p my_list.find(30)
p my_list.contains?(15)

puts my_list.to_s
my_list.pop
puts my_list.to_s