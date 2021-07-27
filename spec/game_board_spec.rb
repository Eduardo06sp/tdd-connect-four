# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  describe '#create_board' do
    it 'returns a hash with 42 keys' do
      board_keys = new_board.create_board.keys
      expect(board_keys.count).to eq(42)
    end
  end
end
