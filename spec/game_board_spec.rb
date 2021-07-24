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
    end
  end
end
