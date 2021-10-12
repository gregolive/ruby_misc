# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/ModuleLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

# Recreating Ruby enumerables with blocks
module Enumerable
  # EACH
  def my_each
    index = 0
    output = []
    while index < size
      yield to_a[index]
      output.push(to_a[index])
      index += 1
    end
    output
  end

  # EACH WITH INDEX
  def my_each_with_index
    index = 0
    output = []
    while index < size
      yield to_a[index], index
      output.push(to_a[index])
      index += 1
    end
    output
  end

  # SELECT
  def my_select
    output = []
    my_each do |element|
      output.push(element) if yield(element)
    end
    output
  end

  # ALL?
  def my_all?(arg = '')
    output = []
    if block_given?
      my_each do |element|
        output.push(element) if yield(element)
      end
    elsif arg == ''
      my_each do |element|
        output.push(element) if element
      end
    else
      my_each do |element|
        arg.is_a?(Regexp) ? (output.push(element) if element.match?(arg)) : (output.push(element) if element.is_a?(arg))
      end
    end
    output == self
  end

  # ANY?
  def my_any?(arg = '')
    if block_given?
      my_each do |element|
        return true if yield(element)
      end
    elsif arg == ''
      my_each do |element|
        return true if element
      end
    else
      my_each do |element|
        if arg.is_a?(Regexp)
          return true if element.match?(arg)
        elsif element.is_a?(arg)
          return true
        end
      end
    end
    false
  end

  # NONE?
  def my_none?(arg = '')
    if block_given?
      my_each do |element|
        return false if yield(element)
      end
    elsif arg == ''
      my_each do |element|
        return false if element
      end
    else
      my_each do |element|
        if arg.is_a?(Regexp)
          return false if element.match?(arg)
        elsif element.is_a?(arg)
          return false
        end
      end
    end
    true
  end

  # COUNT
  def my_count(arg = '')
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield(element) }
    elsif arg != ''
      my_each { |element| count += 1 if element == arg }
    else
      my_each { count += 1 }
    end
    count
  end

  # MAP
  def my_map(*a_proc)
    output = []
    if a_proc[0].nil?
      my_each { |element| output << yield(element) }
    else
      p a_proc[0]
      my_each { |element| output << a_proc[0].call(element) }
    end
    output
  end

  # INJECT
  def my_inject(*args)
    total = to_a[0]
    case args.count
    when 2
      total = args[0]
      operator = args[1]
    when 1
      args[0].is_a?(Integer) ? total = args[0] : operator = args[0]
    end

    if block_given?
      my_each_with_index do |element, index|
        total = yield(total, element) unless index.zero? && !args[0].is_a?(Integer)
      end
    else
      my_each_with_index do |element, index|
        total = total.send(operator, element) unless index.zero? && !args[0].is_a?(Integer)
      end
    end
    total
  end
end

# to test my_inject
def multiply_els(array)
  array.my_inject(:*)
end

# rubocop:enable Metrics/MethodLength, Metrics/ModuleLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
