# frozen_string_literal: true

require_relative '../lib/game_board'
require_relative '../lib/player'

describe GameBoard do
  subject(:new_game) { GameBoard.new }

  describe '#start_game' do
    it 'outputs message' do
      expect(new_game).to receive(:puts).once
      new_game.start_game
    end
  end

  describe '#create_player' do
    it 'creates a new Player instance with given arguments' do
      expect(Player).to receive(:new).with('Sam', 'white_token')
      new_game.create_player('Sam', 'white_token')
    end
  end

  describe '#validate_input' do
    it 'returns input if valid' do
      valid_input = 'c'
      valid_entries = %w[a b c d]
      verified_input = new_game.validate_input(valid_input, valid_entries)
      expect(verified_input).to be('c')
    end

    it 'returns error message if input is invalid' do
      invalid_input = 1
      valid_entries = %w[a b c d]
      verified_input = new_game.validate_input(invalid_input, valid_entries)
      error_message = "Invalid input! Please enter one of the following: #{valid_entries.join(' ')}"
      expect(verified_input).to receive(:puts).with(error_message).once
    end
  end
end
