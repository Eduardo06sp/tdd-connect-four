# frozen_string_literal: true

class GameBoard
  attr_reader :board

  def initialize
    @board = create_board
    @possibilities = board.keys.map(&:to_s)
  end

  def create_board
    board = {}
    x = ('a'..'g').to_a

    x.each do |letter|
      i = 1
      until i == 7
        board["#{letter}#{i}"] = ' '
        i += 1
      end
    end

    board
  end

  def update_board(location, gamepiece)
    board[location] = gamepiece
  end
end
