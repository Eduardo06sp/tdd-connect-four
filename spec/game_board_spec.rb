# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  subject(:new_game) { GameBoard.new }

  describe '#start_game' do
    it 'outputs message' do
      expect(new_game.start_game).to receive(:puts).once
    end
  end
end
