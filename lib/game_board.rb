# frozen_string_literal: true

class ConnectFour
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
  end

  def start_game
    puts 'Welcome to CLI Connect Four! Please press enter to continue...'
  end

  def create_player(name, symbol)
    Player.new(name, symbol)
  end

  def validate_input(valid_input, valid_entries)
    return valid_input if valid_entries.include?(valid_input)

    puts "Invalid input! Please try again."
    input = gets.chomp
    validate_input(input, valid_entries)
  end

  def create_new_game
    puts "Please enter a name for player one, or press enter to use the default:"
    input = gets.chomp
    p1_name = input == '' ? 'Player 1' : input

    puts "Please enter a name for player one, or press enter to use the default:"
    input = gets.chomp
    p2_name = input == '' ? 'Player 2' : input

    puts "#{p1_name}, please choose the color of your gamepiece: black or white"
    input = gets.chomp
    validated_input = validate_input(input, %w[black white])
    p1_token = "#{validated_input}_token"
    p2_token = p1_token == 'black_token' ? 'white_token' : 'black_token'

    player_one = Player.new(p1_name, p1_token)
    player_two = Player.new(p2_name, p2_token)

    ConnectFour.new(player_one, player_two)
  end
end
