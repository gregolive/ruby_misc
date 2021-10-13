# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

# Merge Sort Algorithm
def merge_sort(array)
  return array if array.length <= 1

  left = merge_sort(array[0..((array.length / 2) - 1)])
  right = merge_sort(array[(array.length / 2)..-1])
  merge(left, right)
end

def merge(array1, array2, merged = [])
  until array1.empty? && array2.empty?
    if array1[0].nil?
      merged.push(array2[0])
      array2.delete_at(0)
    elsif array2[0].nil? || array1[0] < array2[0]
      merged.push(array1[0])
      array1.delete_at(0)
    else
      merged.push(array2[0])
      array2.delete_at(0)
    end
  end
  merged
end

array = []
rand(30).times do
  array << rand(30)
end

p array
p merge_sort(array)

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
