# frozen_string_literal: true

class GameBoard
  def initialize
  end

  def start_game
    puts 'Welcome to CLI Connect Four! Please press enter to continue...'
  end

  def create_player(name, symbol)
    Player.new(name, symbol)
  end

  def validate_input(valid_input, valid_entries)
    return valid_input if valid_entries.include?(valid_input)

    puts "Invalid input! Please enter one of the following: #{valid_entries.join(' ')}"
  end
end
