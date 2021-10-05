# frozen_string_literal: true

# BUBBLE SORT - Sorting Algorithm
class BubbleSort
  def initialize(array)
    @array = array
    @iteration = 0
    @changes = 0 # counter for num of changes per iteration
  end

  def sort
    while @iteration < @array.length
      check_element # compare each element to the element to its right
      return p @array if @changes.zero? # if no changes were made then sorting is finished

      @iteration += 1
    end
    p array
  end

  def check_element
    @changes = 0
    @array.each do |element|
      current_index = @array.index(element)

      # don't have to check last element and an additional element on each pass
      break if current_index >= (@array.length - 1 - @iteration)

      # if right element is smaller swap elements
      next unless element > @array[current_index + 1]

      @array[current_index] = @array[current_index + 1]
      @array[current_index + 1] = element
      @changes += 1
    end
  end
end

BubbleSort.new([4, 3, 78, 2, 0, 2]).sort
