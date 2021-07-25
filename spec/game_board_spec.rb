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

    context 'when user inputs an invalid input, then a valid input' do
      before do
        valid_input = 'a'
        allow(new_game).to receive(:gets).and_return(valid_input)
      end

      it 'returns error message if input is invalid' do
        invalid_input = 1
        valid_entries = %w[a b c d]
        error_message = "Invalid input! Please enter one of the following: #{valid_entries.join(' ')}"
        expect(new_game).to receive(:puts).with(error_message).once
        new_game.validate_input(invalid_input, valid_entries)
      end
    end

    context 'when user inputs two invalid inputs, then a valid input' do
      before do
        valid_input = 'b'
        invalid_letter = 'z'

        allow(new_game).to receive(:gets).and_return(invalid_letter, valid_input)
      end

      it 'returns error message twice' do
        invalid_input = 2
        valid_entries = %w[a b c d]

        error_message = "Invalid input! Please enter one of the following: #{valid_entries.join(' ')}"
        expect(new_game).to receive(:puts).with(error_message).twice
        new_game.validate_input(invalid_input, valid_entries)
      end
    end
  end
end
