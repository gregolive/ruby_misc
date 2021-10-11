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
end
