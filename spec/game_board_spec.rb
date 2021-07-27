# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:new_board) { GameBoard.new }

  describe '#create_board' do
    it 'returns a hash with 42 keys' do
      board_keys = new_board.create_board.keys
      expect(board_keys.count).to eq(42)
    end

    it 'contains key A1' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?(:A1)).to be(true)
    end
  end
end
