# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:new_board) { GameBoard.new }

  describe '#create_board' do
    it 'returns a hash with 7 keys' do
      board_keys = new_board.create_board.keys
      expect(board_keys.count).to eq(7)
    end
  end

  describe '@board' do
    it 'hash key 1 contains array with 6 empty spaces' do
      board = new_board.instance_variable_get(:@board)
      expect(board['1']).to eq([' ', ' ', ' ', ' ', ' ', ' '])
    end

    it 'does not contain key 8' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?('8')).to be(false)
    end
  end

  describe '#update_board' do
    context 'when player selects available space c1' do
      xit 'updates c1 with gamepiece' do
        spot = 'c1'
        piece = '⚪'
        board = new_board.instance_variable_get(:@board)
        new_board.update_board(spot, piece)
        expect(board['c1']).to eq('⚪')
      end
    end
  end
end
