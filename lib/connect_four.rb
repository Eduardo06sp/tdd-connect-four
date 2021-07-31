# frozen_string_literal: true

require_relative 'game_board'
require_relative 'terminal_interface'

class ConnectFour
  include TerminalInterface

  attr_accessor :possible_moves, :winner, :turn
  attr_reader :game_board, :player_one, :player_two

  def initialize(player_one, player_two)
    @possible_moves = %w[A1 B1 C1 D1 E1 F1 G1]
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
    input = validate_input(input, valid_entries)
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
      p1_token = '⚪'
      p2_token = '⚫'
    else
      p1_token = '⚫'
      p2_token = '⚪'
    end

    player_one = Player.new(p1_name, p1_token)
    player_two = Player.new(p2_name, p2_token)

    ConnectFour.new(player_one, player_two)
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

  def update_possible_moves(last_move)
    last_move_location = possible_moves.index(last_move)
    updated_y = last_move[1].to_i + 1

    if updated_y > 7
      possible_moves.delete_at(last_move_location)
    else
      new_possible_move = "#{last_move[0]}#{updated_y}"

      possible_moves[last_move_location] = new_possible_move
    end
  end

  def winner?
    x_letters = %w[A B C D E F G]
    visited = []

    game_board.board.each do |k, v|
      next if v == ' ' || visited.include?(k)

      letter_index = x_letters.index(k[0])

      win_combinations = {
        'right_pieces': [
          [letter_index + 1, k[1]],
          [letter_index + 2, k[1]],
          [letter_index + 3, k[1]]
        ],

        'backwards_diagonal_pieces': [
          [letter_index - 1, k[1].to_i + 1],
          [letter_index - 2, k[1].to_i + 2],
          [letter_index - 3, k[1].to_i + 3]
        ],

        'vertical_pieces': [
          [letter_index, k[1].to_i + 1],
          [letter_index, k[1].to_i + 2],
          [letter_index, k[1].to_i + 3]
        ],

        'forwards_diagonal_pieces': [
          [letter_index + 1, k[1].to_i + 1],
          [letter_index + 2, k[1].to_i + 2],
          [letter_index + 3, k[1].to_i + 3]
        ]
      }

      win_combinations.each do |_name, pieces_array|
        possible_wins = [v]

        pieces_array.each do |coordinate|
          break if x_letters[coordinate[0]].nil?

          current_spot = game_board.board["#{x_letters[coordinate[0]]}#{coordinate[1]}"]
          possible_wins.push(current_spot)
          visited.push(current_spot)
        end

        if possible_wins.all? { |possibility| possibility == possible_wins[0] }
          self.winner = if v == '⚪' && player_one.symbol == '⚪'
                          player_one.name
                        else
                          player_two.name
                        end
          return true
        end
      end

      visited.push(k)
    end

    false
  end

  def game_over?
    return true if possible_moves.empty?
    return true if winner?

    false
  end

  def end_game
    if winner?
      puts "Congratulations, #{winner}, you win!"
    else
      puts 'Game over! Game ends in a tie.'
    end
  end
end
