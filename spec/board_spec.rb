require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Board do

  subject(:board) { described_class.new }

  describe '#valid_move?' do

    context 'when number is not between 1 and 7' do
      it 'returns false' do
        expect(board.valid_move?('0')).to be false
        expect(board.valid_move?('8')).to be false
      end
    end

    context 'when number is between 1 and 6 but column is full' do
      before do
        allow(board).to receive(:column_full?).and_return(true)
      end
      it 'returns false' do
        expect(board.valid_move?('4')).to be false
      end
    end

    context 'when number is between 1 and 6 and column is not full' do
      before do
        allow(board).to receive(:column_full?).and_return(false)
      end
      it 'returns false' do
        expect(board.valid_move?('4')).to be true
      end
    end

  end

  describe '#board_full?' do

    context 'When board is full' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"]])
      end
      it 'returns true' do
        expect(board.full?).to be true
      end
    end

    context 'When board is not full' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O"," ","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"]])
      end
      it 'returns false' do
        expect(board.full?).to be false
      end
    end
  end

  describe '#find_consecutive_four' do

    context 'When there is a consecutive_four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","O","O"," "],
          ["O","O","X"," "," "],
          ["X","O","O","O"," "],
          ["O","X","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","O"]])

          board.instance_variable_set(:@last_move, [3,3])
      end
      it 'returns true' do
        expect(board.find_consecutive_four).to eq("O")
      end
    end

    context 'When there is a consecutive_four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","O","O"," "],
          ["O","O","X"," "," "],
          ["X"," "," "," "," "],
          ["O","X"," "," "," "],
          ["X","O"," "," "," "],
          ["X","O","X","O"," "]])

          board.instance_variable_set(:@last_move, [1,3])
      end
      it 'returns true' do
        expect(board.find_consecutive_four).to eq(" ")
      end
    end
    
  end

  describe '#column_full?' do
    context 'When column is full' do
      before do
        board.instance_variable_set(:@arr, 
         [[" ","O","X","O","X"],
          ["X"," "," ","O"," "],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"]])
      end
      it 'returns true' do
        expect(board.column_full?(2)).to be true
      end
    end

    context 'When column is not full' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O"," ","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","O","X"]])
      end
      it 'returns false' do
        expect(board.column_full?(3)).to be false
      end
    end
  end

  describe '#vertical_consecutive_four?' do

    context 'When there is a vertical consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","O","O"," "],
          ["O","O","X"," "," "],
          ["O","O","O","O"," "],
          ["O","X","X","O","X"],
          ["X","O","X","O","X"],
          ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [3,3])
      end
      it 'returns true' do
        expect(board.vertical_consecutive_four?).to be true
      end
    end

    context 'When there is no vertical consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","O","O"," "],
          ["O","O","X"," "," "],
          ["X"," "," "," "," "],
          ["O","X"," "," "," "],
          ["X","O"," "," "," "],
          ["X","O","X","O"," "]])

          board.instance_variable_set(:@last_move, [1,3])
      end
      it 'returns true' do
        expect(board.vertical_consecutive_four?).to be false
      end
    end
  end

  describe '#horizontal_consecutive_four?' do

    context 'When there is a horizontal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","X","O"," "],
          ["O","O","X"," "," "],
          ["O","O","X","O"," "],
          ["O","X","X","O","X"],
          ["X","O","O","O","X"],
          ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [2,2])
      end
      it 'returns true' do
        expect(board.horizontal_consecutive_four?).to be true
      end
    end

    context 'When there is no horizontal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
         ["O","X","O","O"," "],
         ["O","O","X"," "," "],
         ["O","O","X","O"," "],
         ["O","X","X","O","X"],
         ["X","O","O","O","X"],
         ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [2,2])
      end
      it 'returns true' do
        expect(board.horizontal_consecutive_four?).to be false
      end
    end
  end

  describe '#up_right_diagonal_consecutive_four?' do

    context 'When there is a up right diagonal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","O","O","X"," "],
          ["O","O","O"," "," "],
          ["O","X","O","O"," "],
          ["X","O","X","X","O"],
          ["X","O","O","O","X"],
          ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [3,3])
      end
      it 'returns true' do
        expect(board.up_right_diagonal_consecutive_four?).to be true
      end
    end

    context 'When there is no up right diagonal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
         ["O","X","O","O"," "],
         ["O","O","X"," "," "],
         ["O","O","X","O"," "],
         ["O","X","X","O","X"],
         ["X","O","O","O","X"],
         ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [2,2])
      end
      it 'returns true' do
        expect(board.up_right_diagonal_consecutive_four?).to be false
      end
    end
  end

  describe '#up_left_diagonal_consecutive_four?' do

    context 'When there is a up left diagonal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
          ["O","X","O","X"," "],
          ["O","O","X"," "," "],
          ["O","X","O","O"," "],
          ["X","X","X","O","X"],
          ["X","O","O","O","X"],
          ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [2,2])
      end
      it 'returns true' do
        expect(board.up_left_diagonal_consecutive_four?).to be true
      end
    end

    context 'When there is no up left diagonal consecutive four' do
      before do
        board.instance_variable_set(:@arr, 
         [["X","O"," "," "," "],
         ["O","X","O","O"," "],
         ["O","O","X"," "," "],
         ["O","O","X","O"," "],
         ["O","X","X","O","X"],
         ["X","O","O","O","X"],
         ["X","O","X","X","O"]])

          board.instance_variable_set(:@last_move, [2,2])
      end
      it 'returns true' do
        expect(board.up_left_diagonal_consecutive_four?).to be false
      end
    end
  end



  
end