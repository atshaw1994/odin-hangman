require 'yaml'

@dictionary = File.readlines('dict.txt').map(&:chomp)
@incorrect_guesses = []

def init_game
  puts "Welcome to Hangman!"
  puts "Do you want to (1) start a new game or (2) load a saved game?"
  print "Enter 1 or 2: "
  choice = gets.chomp

  case choice
  when "1"
    init_variables()
  when "2"
    unless load_game()
      puts "Starting a new game instead."
      init_variables()
    end
  else
    puts "Invalid choice. Starting a new game."
    init_variables()
  end
  
end

def init_variables
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
    user_guess = gets.chomp.downcase
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

def save_game
  game_state = {
    secret_word: @secret_word,
    board: @board,
    incorrect_guesses: @incorrect_guesses
  }
  print "Enter a name for your save file: "
  filename = gets.chomp + ".yaml"
  File.open(filename, 'w') do |file|
    file.write(YAML.dump(game_state))
  end
  puts "Game saved as '#{filename}'!"
end

def load_game
  saved_games = Dir.glob('*.yaml')
  if saved_games.empty?
    puts "No saved games found."
    return false
  end

  puts "Select a saved game to load:"
  saved_games.each_with_index { |file, index| puts "#{index + 1}. #{file}" }
  print "Enter the number of the file: "
  file_number = gets.chomp.to_i - 1

  if saved_games[file_number]
    filename = saved_games[file_number]
    game_state = YAML.load(File.read(filename))
    @secret_word = game_state[:secret_word]
    @board = game_state[:board]
    @incorrect_guesses = game_state[:incorrect_guesses]
    puts "Game loaded from '#{filename}'!"
    return true
  else
    puts "Invalid selection."
    return false
  end
end

# Main Game Loop
userin_playgame = "Y"
while userin_playgame.downcase == "y"
  init_game()
  while @incorrect_guesses.length < 7 && !check_win()
    print_image
    print_board()
    print "Enter letter or 'save' to save game: "
    user_input = gets.chomp.downcase

    if user_input == "save"
      save_game()
      break
    else
      check_letter(user_input)
    end
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