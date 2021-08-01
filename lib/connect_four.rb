# frozen_string_literal: true

require_relative 'game_board'
require_relative 'terminal_interface'

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

  def start_game
    puts 'Welcome to CLI Connect Four! Please press enter to continue...'
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

  def create_new_game
    puts 'Please enter a name for player one, or press enter to use the default:'
    input = gets.chomp
    p1_name = input == '' ? 'Player 1' : input

    puts 'Please enter a name for player one, or press enter to use the default:'
    input = gets.chomp
    p2_name = input == '' ? 'Player 2' : input

    puts "#{p1_name}, please choose the color of your gamepiece: black or white"
    input = gets.chomp
    validated_input = validate_input(input, %w[black white])
    p1_token = "#{validated_input}_token"

    if p1_token == 'white_token'
      p1_token = '★'
      p2_token = '☆'
    else
      p1_token = '☆'
      p2_token = '★'
    end

    player_one = Player.new(p1_name, p1_token)
    player_two = Player.new(p2_name, p2_token)

    new_game = ConnectFour.new(player_one, player_two)
    new_game.play_rounds
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

  def winner?
    visited = []

    game_board.board.each do |x_value, y_array|
      y_array.each_with_index do |y_value, y_index|
        next if y_value == ' '

        win_combinations = {
          'right_pieces': [
            [x_value.to_i + 1, y_index],
            [x_value.to_i + 2, y_index],
            [x_value.to_i + 3, y_index]
          ],

          'backwards_diagonal_pieces': [
            [x_value.to_i - 1, y_index + 1],
            [x_value.to_i - 2, y_index + 2],
            [x_value.to_i - 3, y_index + 3]
          ],

          'vertical_pieces': [
            [x_value.to_i, y_index + 1],
            [x_value.to_i, y_index + 2],
            [x_value.to_i, y_index + 3]
          ],

          'forwards_diagonal_pieces': [
            [x_value.to_i + 1, y_index + 1],
            [x_value.to_i + 2, y_index + 2],
            [x_value.to_i + 3, y_index + 3]
          ]
        }

        win_combinations.each do |_name, combination_array|
          possible_wins = [y_value]

          combination_array.each do |coordinate|
            break if game_board.board[coordinate[0].to_s].nil? || coordinate[1] > 6

            current_spot = game_board.board[coordinate[0].to_s][coordinate[1]]
            possible_wins.push(current_spot)
            visited.push(current_spot)
          end

          if possible_wins.all? { |possibility| possibility == possible_wins[0] } && possible_wins.length == 4
            self.winner = if y_value == '★' && player_one.symbol == '★'
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
    return true if possible_moves.empty?
    return true if winner?

    false
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
end
