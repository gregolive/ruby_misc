# Returns a caesar cipher given a string and shift value

# frozen_string_literal: true

def caesar_cipher(string, shift)
  # array of a to z both lowercase and uppercase
  low_alphabet = ('a'..'z').to_a
  up_alphabet = ('A'..'Z').to_a

  loop_string(string, low_alphabet, up_alphabet, shift).join
end

# loop over each character in a provided string and check against arrays
def loop_string(string, low_alphabet, up_alphabet, shift, cipher = [])
  string.each_char do |string_char|
    # if the character is a space add the space
    if string_char == ' '
      cipher.push(string_char)
      next
    end

    # check for a lowercase character
    switch_letter(string_char, low_alphabet, cipher, shift)

    # check for an uppercase character
    switch_letter(string_char, up_alphabet, cipher, shift)
  end
  cipher
end

# switch the letters given a character to check, a basis array, an output array and a shift amount
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
puts ''
print 'Please enter a phrase: '
string = gets
print 'Shift by: '
integer = gets
integer = integer.to_i

# display cipher
puts ''
print 'Your top secret code is... '
p caesar_cipher(string, integer)
