# Recreating Ruby enumerables with blocks

module Enumerable
  # EACH
  def my_each
    index = 0
    output = Array.new()
    while index < self.size
      yield self.to_a[index]
      output.push(self.to_a[index])
      index += 1
    end
    output
  end

  # EACH WITH INDEX
  def my_each_with_index
    index = 0
    output = Array.new()
    while index < self.size
      yield self.to_a[index], index
      output.push(self.to_a[index])
      index += 1
    end
    output
  end

  # SELECT
  def my_select
    output = Array.new()
    self.my_each do |element|
      output.push(element) if yield(element)
    end
    output
  end

  # ALL?
  def my_all?(arg = "")
    output = Array.new()
    if block_given?
      self.my_each do |element|
        output.push(element) if yield(element)
      end  
    else
      if arg == ""
        self.my_each do |element|
          output.push(element) if element
        end
      else
        self.my_each do |element|
          arg.is_a?(Regexp) ? (output.push(element) if element.match?(arg)) : (output.push(element) if element.is_a?(arg))
        end
      end
    end
    output == self ? true : false
  end
  
  # ANY?
  def my_any?(arg = "")
    if block_given?
      self.my_each do |element|
        return true if yield(element)
      end  
    else
      if arg == ""
        self.my_each do |element|
          return true if element
        end
      else
        self.my_each do |element|
          if arg.is_a?(Regexp) 
            return true if element.match?(arg)
          else 
            return true if element.is_a?(arg)
          end
        end
      end
    end
    false
  end

  # NONE?
  def my_none?(arg = "")
    if block_given?
      self.my_each do |element|
        return false if yield(element)
      end  
    else
      if arg == ""
        self.my_each do |element|
          return false if element
        end
      else
        self.my_each do |element|
          if arg.is_a?(Regexp) 
            return false if element.match?(arg)
          else 
            return false if element.is_a?(arg)
          end
        end
      end
    end
    true
  end

  # COUNT
  def my_count(count = 0)
    if block_given?
      self.my_each { |element| count += 1 if yield(element) }
    else
      self.my_each { count += 1 }
    end
    count
  end

  # MAP
  def my_map(*a_proc)
    output = Array.new()
    if defined? a_proc
      self.my_each { |element| output << a_proc[0].call(element) }
    else
      self.my_each { |element| output << yield(element) }
    end
    output
  end

  # INJECT
  def my_inject(*args)
    total = self.to_a[0]
    if args.count == 2
      total = args[0]
      operator = args[1]
    elsif args.count == 1
      args[0].is_a?(Integer) ? total = args[0] : operator = args[0]
    end

    if block_given?
      self.my_each_with_index do |element, index|
        total = yield(total,element) unless index == 0 && !args[0].is_a?(Integer)
      end
    else
      self.my_each_with_index do |element, index|
        total = total.send(operator,element) unless index == 0 && !args[0].is_a?(Integer)
      end
    end
    total
  end
end

# to test my_inject
def multiply_els(array)
  array.my_inject(:*)
end
