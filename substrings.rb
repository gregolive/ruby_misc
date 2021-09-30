# takes a string and lists the number of times each word in the string is found in a dictionary array

def substrings(string, dictionary)
  p (dictionary.reduce(Hash.new(0)) { |result, word|
    match = string.downcase.scan(/#{word}/)
    if match.any? then
      result[word] = match.length
    end
    result
  })
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit", "be"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)