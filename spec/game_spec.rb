require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do

  subject(:game) {described_class.new}
  let(:player_one) {instance_double(Player, number: 1, symbol: 'X')}
  let(:player_two) {instance_double(Player, number: 2, symbol: 'O')}
  let(:board) {instance_double(Board)}

  

  describe '#create_characters' do

    context 'when player 1 and player 2 give different inputs' do
      before do
        player_one_symbol = 'X'
        player_two_symbol = 'O'
        allow(game).to receive(:gets).and_return(player_one_symbol,player_two_symbol)
      end
      it 'calls player.new twice with the given symbols' do
        expect(Player).to receive(:new).with(1,'X')
        expect(Player).to receive(:new).with(2,'O')
        game.create_characters
      end
    end

    context 'when player 1 and player 2 give same inputs, then give different inputs' do
      before do
        player_one_symbol = 'X'
        player_two_symbol_first_time = 'X'
        player_two_symbol_second_time = 'O'
        allow(game).to receive(:get_symbol_input).and_return(player_one_symbol, player_two_symbol_first_time, player_two_symbol_second_time)
      end
      it 'prints an error message, then calls player.new twice with the given symbols' do
        expect(Player).to receive(:new).with(1,'X')
        expect(Player).to receive(:new).with(2,'O')
        expect(game).to receive(:print).with('Please enter a different character: ')
        game.create_characters
      end
    end
  end

  describe '#get_symbol_input' do

    context 'when user gives a valid input' do
      before do
        valid_input = 'X'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'returns the valid input' do
        expect(game.get_symbol_input).to eq('X')
      end
    end

    context 'when user gives a invalid input, then a valid input' do
      before do
        invalid_input = 'ab'
        valid_input = 'X'
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'prints an error message, then returns the valid input' do
        expect(game).to receive(:print).with('Please enter only one character: ').once
        result = game.get_symbol_input
        expect(result).to eq('X')

      end
    end

  end

  describe '#get_move_input' do

    context 'when user gives a valid move' do
      before do
        valid_move = "0"
        allow(game).to receive(:gets).and_return(valid_move)
        allow(game.board).to receive(:valid_move?).and_return(true)
      end

      it 'returns the valid input' do
        expect(game.board).to receive(:valid_move?).and_return(true)
        expect(game.get_move_input).to eq(0)
      end
    end

    context 'when user gives a invalid input, then a valid input' do
      before do
        invalid_move = "9"
        valid_move = "0"
        allow(game).to receive(:gets).and_return(invalid_move, valid_move)
        allow(game.board).to receive(:valid_move?).and_return(false, true)
      end

      it 'prints an error message, then returns the valid input' do
        expect(game).to receive(:print).with('Please enter a valid move: ').once
        result = game.get_move_input
        expect(result).to eq(0)

      end
    end
  end

  describe '#game_over?' do

    context 'When player 1 has a consecutive 4' do
      before do
        game.instance_variable_set(:@player_one, player_one)
        game.instance_variable_set(:@player_two, player_two)
        allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(true)
        allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:full?).and_return(false)
      end
      it 'returns true' do
        result = game.game_over?
        expect(result).to be true
      end
    end

    context 'When player 2 has a consecutive 4' do
      before do
        game.instance_variable_set(:@player_one, player_one)
        game.instance_variable_set(:@player_two, player_two)
        allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(true)
        allow(game.board).to receive(:full?).and_return(false)
      end
      it 'returns true' do
        result = game.game_over?
        expect(result).to be true
      end
    end

    context 'When the board is full' do
      before do
        game.instance_variable_set(:@player_one, player_one)
        game.instance_variable_set(:@player_two, player_two)
        allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:full?).and_return(true)
      end
      it 'returns true' do
        result = game.game_over?
        expect(result).to be true
      end
    end

    context 'When the board is not full, and neither player has a consecutive four' do
      before do
        game.instance_variable_set(:@player_one, player_one)
        game.instance_variable_set(:@player_two, player_two)
        allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(false)
        allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:full?).and_return(false)
      end
      it 'returns false' do
        result = game.game_over?
        expect(result).to be false
      end
    end

  end

  describe '#game_results' do
    context 'When player 1 has a consecutive 4' do
      before do
        game.instance_variable_set(:@player_one, player_one)
        game.instance_variable_set(:@player_two, player_two)
        allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(true)
        allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(false)
        allow(game.board).to receive(:full?).and_return(false)
      end
      it 'puts player 1 wins string' do
        expect(game).to receive(:puts).with("Player one wins!")
        game.game_results
      end

      context 'When player 2 has a consecutive 4' do
        before do
          game.instance_variable_set(:@player_one, player_one)
          game.instance_variable_set(:@player_two, player_two)
          allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(false)
          allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(true)
          allow(game.board).to receive(:full?).and_return(false)
        end
        it 'puts player 2 wins string' do
          expect(game).to receive(:puts).with("Player two wins!")
          game.game_results
        end
      end

      context 'When board is full' do
        before do
          game.instance_variable_set(:@player_one, player_one)
          game.instance_variable_set(:@player_two, player_two)
          allow(game.board).to receive(:consecutive_four?).with(game.player_one.symbol).and_return(false)
          allow(game.board).to receive(:consecutive_four?).with(game.player_two.symbol).and_return(false)
          allow(game.board).to receive(:full?).and_return(true)
        end
        it 'puts player 1 wins string' do
          expect(game).to receive(:puts).with("Draw!")
          game.game_results
        end
      end
    end
  end



end