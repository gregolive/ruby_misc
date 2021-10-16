# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Layout/LineLength

# Typing categories
module Categories
  def categories
    fruits = ['apple', 'banana', 'orange', 'mango', 'grapes', 'pineapple', 'strawberry', 'cherry', 'kiwi', 'lemon', 'peach',
              'lime', 'melon', 'pear', 'raspberry', 'grapefruit', 'dragon fruit', 'coconut']
    sports = ['soccer', 'tennis', 'cycling', 'swimming', 'judo', 'surfing', 'baseball', 'karate', 'climbing', 'rugby',
              'badminton', 'table tennis', 'athletics', 'hockey', 'volleyball', 'skiing', 'boxing', 'fishing', 'golf']
    months = %w[January February March April May June July August September October November
                December]
    { 1 => fruits, 2 => sports, 3 => months }
  end
end

# Output to console
module Messages
  def intro
    puts "TYPING PRACTICE\n\nPlease choose a category by entering its number..."
    puts "'1' fruits, '2' sports, '3' months\n"
  end

  def retry_categories
    'You must enter the number for the category.'
  end

  def correct
    "CORRECT 👍 ⭕\n\n"
  end

  def incorrect
    "TRY AGAIN 😔 ❌\n\n"
  end

  def complete
    'F️️️INISHED 😃 ✔️'
  end
end

# Check input
module TestConditions
  include Categories
  include Messages

  def ask_input
    gets.chomp
  end

  def check_input(array, message)
    input = ask_input
    while array.include?(input.to_i) == false
      puts message
      input = ask_input
    end
    input
  end
end

# Run test
class Test
  include Categories
  include Messages
  include TestConditions

  def start
    intro
    category = ask_categories
    puts('')
    run_test(category)
    puts complete
  end

  def ask_categories
    input = check_input(categories.keys, retry_categories)
    categories[input.to_i]
  end

  def run_test(array)
    array.each do |element|
      puts element
      continue = true
      typing(continue, element)
    end
  end

  def typing(boolean, string)
    while boolean == true
      input = gets.chomp
      if input == string
        boolean = false
        puts correct
      else
        puts incorrect
        puts string
        redo
      end
    end
  end
end

Test.new.start

# rubocop:enable Metrics/MethodLength, Layout/LineLength
