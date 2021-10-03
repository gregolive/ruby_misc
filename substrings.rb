# Takes a string and lists the number of times each word in the string is found in a dictionary array

# frozen_string_literal: true

def substrings(string, dictionary)
  p(dictionary.each_with_object(Hash.new(0)) do |word, result|
    match = string.downcase.scan(/#{word}/)
    result[word] = match.length if match.any?
  end)
end

dictionary = %w[below down go going horn how howdy it i low own part partner
                sit be]
substrings('below', dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
