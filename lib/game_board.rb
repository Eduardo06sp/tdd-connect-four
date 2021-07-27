# frozen_string_literal: true

class GameBoard
  def initialize
  end

  def create_board
    board = {}
    x = ('A'..'G').to_a

    x.each do |letter|
      i = 1
      until i == 7
        board["#{letter}#{i}"] = ' '
        i += 1
      end
    end

    board
  end
end
