# frozen_string_literal: true

# Display error messages to the console
module DisplayErrors
  private

  # error messages
  def err_empty_list
    "The list is empty!"
  end

  def err_no_entry(index)
    "The list does not contain #{index} entries."
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

  # inserts a new node at a given index (add to end if index is greater than entries)
  def insert_at(value, index)
    if @head.nil?  || index > @@entries
      append(value)
    elsif index == 1
      prepend(value)
    else
      prev, cur = search_for(index)
      prev.next_node = value
      value.next_node = cur
      @@entries += 1
    end
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

    search_for(index)[1].value
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

  # removes the node at the given index
  def remove_at(index)
    return err_no_entry(index) if index > @@entries

    prev, cur = search_for(index)
    prev.next_node = cur.next_node
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

  private

  def search_for(index)
    cur = @head
    prev = nil
    while index - 1 > 0
      prev = cur
      cur = cur.next_node
      index -= 1
    end
    return [prev, cur]
  end
end

my_list = LinkedList.new
rand(1..2).times {
  my_list.append(Node.new(rand(100)))
  my_list.prepend(Node.new(rand(100)))
  my_list.insert_at(Node.new(rand(100)),rand(1..5))
}

puts my_list.to_s
