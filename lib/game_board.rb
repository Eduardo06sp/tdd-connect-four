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
      board["#{number}"] = (1..6).to_a
    end

    board
  end

  def update_board(location, gamepiece)
    board[location] = gamepiece
  end
end
