# frozen_string_literal: true

# GameBoard initializes with a hash containing keys 1-7 (as string)
# Each key contains an empty space represented by a string
# Depending on the chosen column, the next empty space is replaced by a gamepiece
class GameBoard
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    board = {}
    x = ('1'..'7').to_a

    x.each do |number|
      board[number] = Array.new(6) { ' ' }
    end

    board
  end

  def update_board(column, gamepiece)
    board[column].each_with_index do |row, i|
      if row == ' '
        board[column][i] = gamepiece
        break
      end
    end
  end
end
