# TIC TAC TOE Game with 2 human players

# Can win vertically, horizontally or diagonally
module WinConditions
  def all_same?(array)
    array.all? {|e| e == array[0]}
  end

  def horizontal_win(a)
    if all_same?(a[0..2]) || all_same?(a[3..5]) || all_same?(a[6..8])
      return true
    end
  end

  def vertical_win(a)
    column1 = [a[0], a[3], a[6]]
    column2 = [a[1], a[4], a[7]]
    column3 = [a[2], a[5], a[8]]
    if all_same?(column1) || all_same?(column2) || all_same?(column3)
      return true
    end
  end

  def diagonal_win(a)
    diagonal1 = [a[0], a[4], a[8]]
    diagonal2 = [a[2], a[4], a[6]]
    if all_same?(diagonal1) || all_same?(diagonal2)
      return true
    end
  end
end

class Player
  include WinConditions
  attr_reader :name, :marker
  
  @@round_number = 0
  @@board = "1 | 2 | 3\n―――――――――\n4 | 5 | 6\n―――――――――\n7 | 8 | 9"
  @@board_list = [1, 2, 3, 4, 5, 6, 7, 8, 9] # so that users don't replace board lines with their move
  @@winner = false

  # Class methods

  def self.round_number
    @@round_number
  end

  def self.winner?
    @@winner
  end

  def self.board
    @@board
  end

  # Public instance methods

  def ask_questions
    ask_for_name
    ask_for_marker
  end

  def make_a_move
    @@round_number += 1
    puts "\n―――――――――――――――――――――― ROUND #{@@round_number} ――――――――――――――――――――――"
    print "\n#{@name}'s turn.\n\n"
    puts @@board
    ask_for_move
    change_board
  end

  def check_winner
    if horizontal_win(@@board_list) || vertical_win(@@board_list) || diagonal_win(@@board_list)
      puts "\n――――――――――――――――――――― GAME OVER ―――――――――――――――――――――"
      puts "\nCONGRATS! #{@name} is the winner!\n\n"
      @@winner = !@@winner
    end
  end
  
  # Protected instance methods
  protected

  # for setup...
  def ask_for_name
    print "Enter your name: "
    @name = gets.chomp
  end
  
  def ask_for_marker
    print "Type one non-number character for your game marker: "
    @marker = gets.chomp

    marker_length_check
    marker_number_check
  end

  def marker_length_check
    # only allow one character
    while @marker.length > 1
      print "ERROR: #{@marker} is longer than 1 character.\n"
      print "Type one non-number character for your game marker: "
      @marker = gets.chomp
    end
  end

  def marker_number_check
    # don't allow numbers
    while @@board.include?(@marker) || @marker == 0
      print "ERROR: #{@marker} is a number.\n"
      print "Type one non-number character for your game marker: "
      @marker = gets.chomp
    end
  end

  # for game actions...
  def ask_for_move
    print "\nChoose a number to place your marker: "
  end

  def change_board
    number = gets.chomp
    while @@board_list.include?(number.to_i) == false
      print "ERROR: You must choose a number from the board."
      ask_for_move
      number = gets.chomp
    end
    sub_number(number)
  end

  def self.game_reset
    @@board = "1 | 2 | 3\n―――――――――\n4 | 5 | 6\n―――――――――\n7 | 8 | 9"
    @@board_list = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @@round_number = 0
    @@winner = false
  end

  def sub_number(number)
    @@board_list.map! { |e| 
      e == number.to_i ? e = @marker : e
    }
    @@board.sub! number, @marker
  end

end

class Player1 < Player
  def setup
    puts "PLAYER 1"
    ask_questions
  end
end

class Player2 < Player
  def setup
    puts "\nPLAYER 2"
    ask_questions
  end
end

# Opening and player set up

# retro style opening
=begin
print "Initializing"
sleep(0.8)
print " ."
sleep(0.8)
print " ."
sleep(0.8)
print " ."
sleep(0.8)
=end
puts "\n\n――――――――――――――――― RETRO TIC TAC TOE ―――――――――――――――――\n\n"

# set up the game
player1 = Player1.new()
player1.setup

player2 = Player2.new()
player2.setup
# player 2 can't use the same marker as player 1
while player2.marker == player1.marker
  print "ERROR: #{player1.name} is using #{player2.marker} already.\n"
  player2.ask_for_marker
end

# Play tic tac toe
play = true
while play == true
  random_start = [true, false] #random player goes first
  player_one_turn = random_start[rand(2) - 1]

  while Player.round_number < 9 && Player.winner? == false
    if player_one_turn == true
      player1.make_a_move
      player1.check_winner
    else
      player2.make_a_move
      player2.check_winner
    end
    player_one_turn = !player_one_turn
  end

  print Player.winner? ? '' : "\n――――――――――――――――――――― GAME OVER ―――――――――――――――――――――\n\nIt's a tie!\n\n"
  puts Player.board

  print "\n\nWould you like to play again? (Y/N)\n"
  again_response = gets.chomp

  while !(again_response == "Y" || again_response == "N")
    puts "ERROR: Type 'Y' for YES and 'N' for NO."
    print "\nWould you like to play again? (Y/N)\n"
    again_response = gets.chomp
  end

  if again_response == "N"
     play = false
     puts "Thank you for playing!"
  else
    Player.game_reset
  end
end