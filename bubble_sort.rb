# BUBBLE SORT - Sorting Algorithm

# frozen_string_literal: true

def bubble_sort(array)
  n = array.length # have to pass through n-1 times
  iteration = 0 # counter for the number of passes

  while iteration < n
    changes = 0 # counter for num of changes per iteration

    # compare each element to the element to its right
    array.each do |element|
      current_index = array.index(element)

      # don't have to check last element and an additional element on each pass
      break if current_index >= (n - 1 - iteration)

      # if right element is smaller swap elements
      next unless element > array[current_index + 1]

      array[current_index] = array[current_index + 1]
      array[current_index + 1] = element
      changes += 1
    end

    # if no changes were made then sorting is finished
    return p array if changes.zero?

    iteration += 1
  end
  p array
end

bubble_sort([4, 3, 78, 2, 0, 2])
