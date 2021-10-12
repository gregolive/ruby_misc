# A collection of recursive methods 

# Fibonacci (Iterative)
def fibs(num)
  output = Array.new
  while num > 0
    (output.length == 0 || output.length == 1) ? output.push(output.length) : output.push(output[(output.length - 1)] + output[(output.length - 2)])
    num -= 1
  end 
  output
end


# Fibonacci (Recursive)
def fibs_rec(num, output = [])
  return output if num <= 0
  (output.length == 0 || output.length == 1) ? output.push(output.length) : output.push(output[(output.length - 1)] + output[(output.length - 2)])
  return fibs_rec(num-1, output)
end

# Collatz Conjecture
