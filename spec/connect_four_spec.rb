# frozen_string_literal: true

require_relative '../lib/connect_four'
require_relative '../lib/player'

describe ConnectFour do
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }
  subject(:new_game) { ConnectFour.new(player_one, player_two) }

  before do |exception|
    unless exception.metadata[:skip_before]
      allow(player_one).to receive(:name)
      allow(player_two).to receive(:name)
    end
  end

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
        error_message = "Invalid input! Please try again."
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

        error_message = "Invalid input! Please try again."
        expect(new_game).to receive(:puts).with(error_message).twice
        new_game.validate_input(invalid_input, valid_entries)
      end
    end
  end

  describe '#create_new_game' do
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }

    it 'creates a new ConnectFour instance' do
      allow(new_game).to receive(:puts).exactly(3).times
      allow(new_game).to receive(:gets).and_return('').twice
      allow(new_game).to receive(:gets).and_return('black')
      expect(ConnectFour).to receive(:new)
      new_game.create_new_game
    end
  end

  describe '#change_turn', :skip_before do
    let(:player_one) { Player.new('Player 1', 'black_token') }
    let(:player_two) { Player.new('Player 2', 'white_token') }
    subject(:new_game) { ConnectFour.new(player_one, player_two) }

    it 'sets @turn to other player' do
      expect { new_game.change_turn }.to change { new_game.instance_variable_get(:@turn) }.to('Player 2')
    end
  end

  describe '#winner?' do
    before do
      allow(player_one).to receive(:symbol).and_return('★')
    end

    it 'returns true if horizontal win present' do
      board = new_game.instance_variable_get(:@game_board)

      board.update_board('A1', '★')
      board.update_board('B1', '★')
      board.update_board('C1', '★')
      board.update_board('D1', '★')

      expect(new_game.winner?).to be(true)
    end

    it 'returns true if backwards diagonal win present' do
      board = new_game.instance_variable_get(:@game_board)

      board.update_board('A4', '★')
      board.update_board('B3', '★')
      board.update_board('C2', '★')
      board.update_board('D1', '★')

      expect(new_game.winner?).to be(true)
    end

    it 'returns true if vertical win present' do
      board = new_game.instance_variable_get(:@game_board)

      board.update_board('A1', '★')
      board.update_board('A2', '★')
      board.update_board('A3', '★')
      board.update_board('A4', '★')

      expect(new_game.winner?).to be(true)
    end

    it 'returns true if forwards diagonal win present' do
      board = new_game.instance_variable_get(:@game_board)

      board.update_board('A1', '★')
      board.update_board('B2', '★')
      board.update_board('C3', '★')
      board.update_board('D4', '★')

      expect(new_game.winner?).to be(true)
    end

    it 'returns false if no win is present' do
      board = new_game.instance_variable_get(:@game_board)

      board.update_board('A1', '★')
      board.update_board('B2', '★')
      board.update_board('C3', '★')
      board.update_board('D5', '★')

      expect(new_game.winner?).to be(false)
    end
  end

  describe '#game_over?' do
    it 'returns true if #winner? is true' do
      allow(new_game).to receive(:winner?).and_return(true)
      expect(new_game.game_over?).to be(true)
    end

    it 'returns false if #winner? is false' do
      allow(new_game).to receive(:winner?).and_return(false)
      expect(new_game.game_over?).to be(false)
    end

    it 'returns true if there are no possible moves left' do
      new_game.instance_variable_set(:@possible_moves, [])
      expect(new_game.game_over?).to be(true)
    end

    it 'returns false if board is empty' do
      expect(new_game.game_over?).to be(false)
    end
  end

  describe '#make_next_move' do
  end

  describe '#update_possible_moves' do
    it 'updates A1 to A2 when gamepiece fills A1' do
      possible_moves = new_game.instance_variable_get(:@possible_moves)
      last_move = 'A1'

      new_game.update_possible_moves(last_move)
      expect(possible_moves).to eq(%w[A2 B1 C1 D1 E1 F1 G1])
    end

    it 'updates G3 to G4 when last move is G3' do
      new_game.instance_variable_set(:@possible_moves, %w[A1 B1 C1 D1 E1 F1 G3])
      possible_moves = new_game.instance_variable_get(:@possible_moves)
      last_move = 'G3'

      new_game.update_possible_moves(last_move)
      expect(possible_moves).to eq(%w[A1 B1 C1 D1 E1 F1 G4])
    end

    it 'removes element if last move is G7' do
      new_game.instance_variable_set(:@possible_moves, %w[A1 B1 C1 D1 E1 F1 G7])
      possible_moves = new_game.instance_variable_get(:@possible_moves)
      last_move = 'G7'

      new_game.update_possible_moves(last_move)
      expect(possible_moves).to eq(%w[A1 B1 C1 D1 E1 F1])
    end
  end

  describe '#end_game' do
    let(:player_one) { Player.new('Player 1', 'black_token') }
    let(:player_two) { Player.new('Player 2', 'white_token') }
    subject(:new_game) { ConnectFour.new(player_one, player_two) }

    it 'congratulates player one if player one wins' do
      new_game.instance_variable_set(:@winner, player_one.name)
      winner = new_game.instance_variable_get(:@winner)
      win_message = "Congratulations, #{winner}, you win!"

      allow(new_game).to receive(:winner?).and_return(true)
      expect(new_game).to receive(:puts).with(win_message)
      new_game.end_game
    end

    it 'congratulates player two if player two wins' do
      new_game.instance_variable_set(:@winner, player_two.name)
      winner = new_game.instance_variable_get(:@winner)
      win_message = "Congratulations, #{winner}, you win!"

      allow(new_game).to receive(:winner?).and_return(true)
      expect(new_game).to receive(:puts).with(win_message)
      new_game.end_game
    end

    it 'displays tie message if neither player wins' do
      tie_message = 'Game over! Game ends in a tie.'

      allow(new_game).to receive(:winner?).and_return(false)
      expect(new_game).to receive(:puts).with(tie_message)
      new_game.end_game
    end
  end
end
