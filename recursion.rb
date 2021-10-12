# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Layout/LineLength

# A collection of recursive methods

# Fibonacci (Iterative)
def fibs(num)
  output = []
  while num.positive?
    output.length.zero? || output.length == 1 ? output.push(output.length) : output.push(output[(output.length - 1)] + output[(output.length - 2)])
    num -= 1
  end
  output
end

# Fibonacci (Recursive)
def fibs_rec(num, output = [])
  return output if num <= 0

  output.length.zero? || output.length == 1 ? output.push(output.length) : output.push(output[(output.length - 1)] + output[(output.length - 2)])
  fibs_rec(num - 1, output)
end

# Collatz Conjecture
def collatz(num, count = 0)
  return count if num <= 1

  num.even? ? collatz(num / 2, count += 1) : collatz(3 * num + 1, count += 1)
end

# Factorial
def fact(num)
  return 1 if num <= 0

  num * fact(num - 1)
end

# Palindrome
def palindrome(str)
  return true if str.length < 2

  str.strip!
  return false unless str[0].downcase == str[-1].downcase

  palindrome(str.slice!(1..-2))
end

# Bottles of beer
def beer(bottles)
  return 'No more bottles of beer on the wall' if bottles <= 0

  puts "#{bottles} of beer on the wall"
  beer(bottles - 1)
end

# Flatten Array
def my_flatten(array, output = [])
  array.each do |element|
    if element.is_a?(Array)
      my_flatten(element, output)
    else
      output << element
    end
  end
  output
end

# Integer to Roman Numeral
def int_to_roman(roman_mapping, int, output = '')
  return output if int <= 0

  roman_mapping.each do |key, value|
    next unless int >= key

    result = int.divmod(key)
    output += value * result[0]
    int = result[1]
    return int_to_roman(roman_mapping, int, output)
  end
end

# Roman Numeral to Int
def roman_to_int(roman_mapping, string, output = 0)
  return output if string == ''

  roman_mapping.each do |key, value|
    if value.length == 1
      if string[0] == value
        string.slice!(value)
        output += key
        return roman_to_int(roman_mapping, string, output)
      end
    elsif string[0..1] == value
      string.slice!(value)
      output += key
      return roman_to_int(roman_mapping, string, output)
    end
  end
end

roman_mapping = {
  1000 => 'M',
  900 => 'CM',
  500 => 'D',
  400 => 'CD',
  100 => 'C',
  90 => 'XC',
  50 => 'L',
  40 => 'XL',
  10 => 'X',
  9 => 'IX',
  5 => 'V',
  4 => 'IV',
  1 => 'I'
}

# rubocop:enable Metrics/MethodLength, Layout/LineLength
