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
    it 'hash key 1 contains array with numbers 1-6' do
      board = new_board.instance_variable_get(:@board)
      expect(board['1']).to eq([1, 2, 3, 4, 5, 6])
    end

    it 'does not contain key 8' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?('8')).to be(false)
    end
  end

  describe '@possibilities' do
    xit 'is an array with 42 elements' do
      possibilities = new_board.instance_variable_get(:@possibilities)
      expect(possibilities.count).to be(42)
    end

    xit 'contains string a1' do
      possibilities = new_board.instance_variable_get(:@possibilities)
      expect(possibilities.include?('a1')).to be(true)
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
