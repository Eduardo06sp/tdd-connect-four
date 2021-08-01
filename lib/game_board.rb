# frozen_string_literal: true

class GameBoard
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    board = {}
    x = ('1'..'7').to_a

    x.each do |number|
      board[number.to_s] = Array.new(6) { ' ' }
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
