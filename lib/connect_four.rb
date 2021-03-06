# frozen_string_literal: true

require_relative 'game_board'
require_relative 'terminal_interface'

# ConnectFour contains the core methods required to run the game
# New Player, GameBoard and ConnectFour instances are created
# Game state is tracked through instance variables containing:
# the game board (and its spaces), the players, and possible moves
#
# The winner is tracked, initializing with nil, representing a tie if the game ends
# The first player starts and turns are alternated in #change_turn
class ConnectFour
  include TerminalInterface

  attr_accessor :possible_moves, :winner, :turn
  attr_reader :game_board, :player_one, :player_two

  def initialize(player_one, player_two)
    @possible_moves = %w[1 2 3 4 5 6 7]
    @player_one = player_one
    @player_two = player_two
    @game_board = GameBoard.new
    @winner = nil
    @turn = player_one
  end

  def create_player(name, symbol)
    Player.new(name, symbol)
  end

  def validate_input(valid_input, valid_entries)
    return valid_input if valid_entries.include?(valid_input)

    puts 'Invalid input! Please try again.'
    input = gets.chomp
    validate_input(input, valid_entries)
  end

  def play_rounds
    return end_game if game_over?

    display_game

    puts "#{turn.name}, please make a move."
    input = gets.chomp
    input = validate_input(input, possible_moves)

    game_board.update_board(input, turn.symbol)
    update_possible_moves(input)

    change_turn
    play_rounds
  end

  def change_turn
    self.turn = if turn == player_one
                  player_two
                else
                  player_one
                end
  end

  def update_possible_moves(column)
    possible_moves.delete(column) if game_board.board[column].none? { |row| row == ' ' }
  end

  def winner?
    visited = []

    game_board.board.each do |x_value, y_array|
      y_array.each_with_index do |y_value, y_index|
        next if y_value == ' '

        win_combinations = generate_win_combinations(x_value, y_index)
        win_combinations.each do |_name, combination_array|
          possible_wins = [y_value]

          combination_array.each do |coordinate|
            break if game_board.board[coordinate[0].to_s].nil? || coordinate[1] > 6

            current_spot = game_board.board[coordinate[0].to_s][coordinate[1]]
            possible_wins.push(current_spot)
            visited.push(current_spot)
          end

          if four_in_a_row?(possible_wins)
            self.winner = if y_value == '???' && player_one.symbol == '???'
                            player_one.name
                          else
                            player_two.name
                          end
            return true
          end
        end

        visited.push(y_value)
      end
    end

    false
  end

  def game_over?
    possible_moves.empty? || winner?
  end

  def end_game
    display_game

    if winner?
      puts "Congratulations, #{winner}, you win!"
    else
      puts 'Game over! Game ends in a tie.'
    end

    rematch
  end

  private

  def create_new_game
    p1_name = get_player_name('one')
    p2_name = get_player_name('two')

    p1_token = get_player_symbol(p1_name)
    p2_token = p1_token == '???' ? '???' : '???'

    player_one = Player.new(p1_name, p1_token)
    player_two = Player.new(p2_name, p2_token)

    new_game = ConnectFour.new(player_one, player_two)
    new_game.play_rounds
  end

  def get_player_name(id)
    puts "Please enter a name for player #{id}, or press enter to use the default:"
    input = gets.chomp

    id_to_number = id == 'one' ? '1' : '2'
    input == '' ? "Player #{id_to_number}" : input
  end

  def get_player_symbol(name)
    puts "#{name}, please choose the color of your gamepiece: black or white"
    input = gets.chomp
    validated_input = validate_input(input, %w[black white])
    player_token = "#{validated_input}_token"

    player_token == 'white_token' ? '???' : '???'
  end

  def generate_win_combinations(x, y)
    {
      'right_pieces': [
        [x.to_i + 1, y],
        [x.to_i + 2, y],
        [x.to_i + 3, y]
      ],

      'backwards_diagonal_pieces': [
        [x.to_i - 1, y + 1],
        [x.to_i - 2, y + 2],
        [x.to_i - 3, y + 3]
      ],

      'vertical_pieces': [
        [x.to_i, y + 1],
        [x.to_i, y + 2],
        [x.to_i, y + 3]
      ],

      'forwards_diagonal_pieces': [
        [x.to_i + 1, y + 1],
        [x.to_i + 2, y + 2],
        [x.to_i + 3, y + 3]
      ]
    }
  end

  def four_in_a_row?(game_pieces)
    game_pieces.all? { |game_piece| game_piece == game_pieces[0] } && game_pieces.length == 4
  end

  def rematch
    puts 'Would you like to play again? Please type in y / yes / n / no.'

    input = gets.chomp
    input = validate_input(input, %w[y yes n no])

    if %w[y yes].include?(input)
      create_new_game
    else
      puts 'Have a wonderful day! :}'
    end
  end
end
