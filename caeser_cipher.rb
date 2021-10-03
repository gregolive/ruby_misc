# Returns a caesar cipher given a string and shift value

# frozen_string_literal: true

def caesar_cipher(string, shift)
  # array of a to z both lowercase and uppercase
  low_alphabet = ('a'..'z').to_a
  up_alphabet = ('A'..'Z').to_a
  cipher = []

  # loop over each character in the provided string
  loop_string(string, low_alphabet, up_alphabet, shift)

  cipher.join
end

# method to loop over each character in a provided string and check against arrays
def loop_string(string, array_low, array_up, shift)
  string.each_char do |string_char|
    # if the character is a space add the space
    if string_char == ' '
      cipher.push(string_char)
      next
    end

    # check for a lowercase character
    switch_letter(string_char, array_low, cipher, shift)

    # check for an uppercase character
    switch_letter(string_char, array_up, cipher, shift)
  end
end

# method to switch letters
def switch_letter(character, array, output, shift)
  array.each do |value|
    next unless value == character

    new_index = array.index(value) + shift
    # wrap z back to a
    new_index -= 26 while new_index > 25
    output.push(array[new_index])
  end
end

# ask for input
puts 'CAESAR CIPHER GENERATOR'
print 'Please enter a phrase: '
string = gets
print 'Shift by: '
integer = gets
integer = integer.to_i

# display cipher
print 'Your top secret code is... '
p caesar_cipher(string, integer)
