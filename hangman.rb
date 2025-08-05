@dictionary = File.readlines('dict.txt').map(&:chomp)
@secret_word = "" # ex. "cat"
@board = [] # ex. ["_", "_", "_"] for "cat"
@incorrect_guesses = []

def initialize_game
  valid_words = @dictionary.select { |word| word.length.between?(5, 12) }
  @secret_word = valid_words.sample
  if @secret_word.nil?
    puts "Error: No valid words between 5 and 12 characters found in the dictionary."
    exit
  end
  @board = Array.new(@secret_word.length, "_")
  @incorrect_guesses = []
end

def announce_win
  puts "You Won!"
  puts "The secret word was: " + @secret_word
end

def announce_loss
  puts "You Lost."
  puts "The secret word was: " + @secret_word
end

def print_board
  puts "-" * (@board.length * 2)
  puts @board.join(' ')
  puts ""
end

def print_image
  case @incorrect_guesses.length
  when 0
    puts "|-----|"
    puts "|"
    puts "|"
    puts "|"
    puts "|"
  when 1
    puts "|-----|"
    puts "|     O"
    puts "|"
    puts "|"
    puts "|"
  when 2
    puts "|-----|"
    puts "|     O"
    puts "|     |"
    puts "|"
    puts "|"
  when 3
    puts "|-----|"
    puts "|     O"
    puts "|    -|"
    puts "|"
    puts "|"
  when 4
    puts "|-----|"
    puts "|     O"
    puts "|    -|-"
    puts "|"
    puts "|"
  when 5
    puts "|-----|"
    puts "|     O"
    puts "|    -|-"
    puts "|     |"
    puts "|"
  when 6
    puts "|-----|"
    puts "|     O"
    puts "|    -|-"
    puts "|     |"
    puts "|    /"
  when 7
    puts "|-----|"
    puts "|     O"
    puts "|    -|-"
    puts "|     |"
    puts "|    / \\"
  end
  puts "--------"
end

def check_letter(user_guess)
  user_guess = user_guess.downcase
  while @incorrect_guesses.include?(user_guess) || @board.include?(user_guess)
    puts "That has already been guessed."
    print "Enter another letter: "
    user_guess = gets.chomp
  end
  if @secret_word.include?(user_guess)
    (@secret_word.length).times do |i|
      if @secret_word[i].downcase == user_guess
        @board[i] = user_guess
      end
    end
  else
    @incorrect_guesses << user_guess
  end
end

def check_win
  return !@board.include?("_")
end

userin_playgame = "Y"
while userin_playgame.downcase == "y"
  initialize_game()
  while @incorrect_guesses.length < 7 && !check_win()
    print_image
    print_board()
    puts "Incorrect: " + @incorrect_guesses.join(", ")
    print "Enter letter: "
    user_guess = gets.chomp
    check_letter(user_guess)
  end

  if check_win()
    announce_win()
  else
    print_image()
    announce_loss()
  end

  puts "Play again? (Y)es or (N)o"
  userin_playgame = gets.chomp
end