# BUBBLE SORT - Sorting Algorithm

def bubble_sort(array)
  n = array.length # have to pass through n-1 times
  iteration = 0 # counter for the number of passes

  while iteration < n
    changes = 0 # counter for num of changes per iteration

    # compare each element to the element to its right
    array.each { |element|
      
      current_index = array.index(element)
    
      # don't have to check last element and an additional element on each pass
      if current_index >= (n - 1 - iteration)
        break
      end
      
      # if right element is smaller swap elements
      if element > array[current_index + 1]
        array[current_index] = array[current_index + 1]
        array[current_index + 1] = element
        changes += 1
      end
    }

    # if no changes were made then sorting is finished
      if changes == 0 
        return p array
      end

    iteration += 1
  end
  p array
end

bubble_sort([4,3,78,2,0,2])