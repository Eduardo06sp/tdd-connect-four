# frozen_string_literal: true

require_relative 'game_board'

class ConnectFour
  attr_accessor :turn
  attr_reader :game_board, :player_one, :player_two

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @game_board = GameBoard.new
    @turn = player_one.name
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

  def change_turn
    self.turn = if turn == player_one.name
                  player_two.name
                else
                  player_one.name
                end
  end

  def game_over?
    x_letters = %w[A B C D E F G]
    visited = []

    game_board.board.each do |k, v|
      next if v == ' ' || visited.include?(k)

      letter_index = x_letters.index(k[0])

      possible_wins = [v]
      # search_right
      right_pieces = [
        [letter_index + 1],
        [letter_index + 2],
        [letter_index + 3]
      ]

      right_pieces.each do |x|
        break if x_letters[x[0]].nil?

        possible_wins.push(game_board.board["#{x_letters[x[0]]}#{k[1]}"])
      end

      return true if possible_wins.all? { |possibility| possibility == possible_wins[0] }

      # search_top_left
      # search_top
      # search_top_right

      visited.push(k)
    end

    false
  end
end
