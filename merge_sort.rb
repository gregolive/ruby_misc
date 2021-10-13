# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

# Merge Sort Algorithm
def merge_sort(array)
  return array if array.length <= 1

  #sort the left half of the array
  left_half = array[0..((array.length / 2) - 1)]
  left_half = merge_sort(left_half) if left_half.length > 2
  if left_half.length != 1 && left_half[0] > left_half[1]
    left_half[0], left_half[1] = left_half[1], left_half[0]
  end

  #sort the right half of the array
  right_half = array[(array.length / 2)..-1]
  right_half = merge_sort(right_half) if right_half.length > 2
  if right_half.length != 1 && right_half[0] > right_half[1]
    right_half[0], right_half[1] = right_half[1], right_half[0]
  end

  #merge sorted halves
  return order_arrays(left_half, right_half)
end

def order_arrays(array1, array2, new_array = [])
  until array1.length == 0 && array2.length == 0
    if array1[0].nil?
      new_array.push(array2[0])
      array2.delete_at(0)
    elsif array2[0].nil? || array1[0] < array2[0]
      new_array.push(array1[0])
      array1.delete_at(0)
    else
      new_array.push(array2[0])
      array2.delete_at(0)
    end
  end
  new_array
end

p merge_sort([8,15,1,7,3,2,6,4,9,5,12])

# rubocop:enable Metrics/MethodLength
