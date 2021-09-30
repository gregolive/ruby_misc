# Returns a caesar cipher given a string and shift value

def caesar_cipher(string, shift)
  # array of a to z both lowercase and uppercase
  low_alphabet = ("a".."z").to_a
  up_alphabet = ('A'..'Z').to_a
  cipher = []

  # loop over each character in the provided string
  string.each_char { |string_char|

    # if the character is a space add the space
    if string_char == " " then 
      cipher.push(string_char) 
      next
    end
    
    # check for a lowercase character
    switch_letter(string_char, low_alphabet, cipher, shift)

    # check for an uppercase character
    switch_letter(string_char, up_alphabet, cipher, shift)
  }

  cipher.join
end

# method to switch letters
def switch_letter(character, array, output, shift)
  array.each { |value|
    if value == character then
      new_index = array.index(value) + shift
      # wrap z back to a
      while new_index > 25 do 
        new_index -= 26
      end
      output.push(array[new_index])
    end
  }
end

# ask for input
puts "CAESAR CIPHER GENERATOR"
print "Please enter a phrase: "
string = gets
print "Shift by: "
integer = gets
integer = integer.to_i

# display cipher
print "Your top secret code is... "
p caesar_cipher(string, integer)