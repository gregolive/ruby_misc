# Recreating Ruby enumerables with blocks

module Enumerable
  # EACH
  def my_each
    index = 0
    while index < self.length
      yield self[index]
      index += 1
    end
  end

  # EACH WITH INDEX
  def my_each_with_index
    index = 0
    while index < self.length
      yield self[index], index
      index += 1
    end
  end
end