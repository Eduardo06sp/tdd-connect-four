# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:new_board) { GameBoard.new }

  describe '#create_board' do
    it 'returns a hash with 42 keys' do
      board_keys = new_board.create_board.keys
      expect(board_keys.count).to eq(42)
    end
  end

  describe '@board' do
    it 'contains key A1' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?('A1')).to be(true)
    end

    it 'contains key G6' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?('G6')).to be(true)
    end

    it 'does not contain key D7' do
      board = new_board.instance_variable_get(:@board)
      expect(board.key?('D7')).to be(false)
    end
  end

  describe '@possibilities' do
    it 'is an array with 42 elements' do
      possibilities = new_board.instance_variable_get(:@possibilities)
      expect(possibilities.count).to be(42)
    end

    it 'contains string A1' do
      possibilities = new_board.instance_variable_get(:@possibilities)
      expect(possibilities.include?('A1')).to be(true)
    end
  end

  describe '#update_board' do
    context 'when player selects available space C1' do
      it 'updates C1 with gamepiece' do
        spot = 'C1'
        piece = 'white_token'
        board = new_board.instance_variable_get(:@board)
        new_board.update_board(spot, piece)
        expect(board['C1']).to eq('white_token')
      end
    end
  end

  describe '#change_turn' do
  end
end
