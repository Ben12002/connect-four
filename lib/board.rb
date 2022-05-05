class Board

  def initialize
    @arr = [[" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " "]]
    @last_move = []
  end

  def add_to_board(num, symbol)
    column_number = num
    row_number = @arr[num].index(" ")
    @arr[column_number][row_number] = symbol
    @last_move = [column_number, row_number]
  end

  def valid_move?(move)
    move.match?(/[1-7]/) && (move.to_i <= 7) && (move.to_i >= 1) && !column_full?(move.to_i - 1)
  end

  def full?
    @arr.all?{|column| column.none?{|elt| elt == " "}}
  end

  # Uses last move to check all directions if there is a consecutive_four
  def find_consecutive_four
    return @arr[@last_move[0]][@last_move[1]] if (vertical_consecutive_four? || 
                                                  horizontal_consecutive_four? || 
                                                  up_right_diagonal_consecutive_four? ||
                                                  up_left_diagonal_consecutive_four?)
    return " "                                             
  end

  def consecutive_four?(symbol)
    find_consecutive_four == symbol
  end

  def column_full?(num)
    @arr[num].none?{|elt| elt == " "}
  end

  def vertical_consecutive_four?
    x = @last_move[0]
    y = @last_move[1]
    symbol = @arr[x][y]

    return false if y < 3

    i = y
    flag = true
    while i >= 0
      flag = false if @arr[x][i] != symbol
      i -= 1
    end
    flag
  end

  def horizontal_consecutive_four?
    x = @last_move[0]
    y = @last_move[1]
    symbol = @arr[x][y]

    # go left
    i = x - 1
    no_of_consecutive = 1
    while i >= 0
      break if @arr[i][y] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i -= 1
    end

    # go right
    i = x + 1
    while i < 7
      break if @arr[i][y] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i += 1
    end
 
    false
  end

  def up_right_diagonal_consecutive_four?
    x = @last_move[0]
    y = @last_move[1]
    symbol = @arr[x][y]
  
    # go down left
    i = x - 1
    j = y - 1
    no_of_consecutive = 1
    while i >= 0 && j >= 0
      break if @arr[i][j] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i -= 1
      j -= 1
    end
  
    # go up right
    i = x + 1
    j = y + 1
    while i < 7 && j < 5
      break if @arr[i][j] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i += 1
      j += 1
    end
  
    false
  end

  def up_left_diagonal_consecutive_four?
    x = @last_move[0]
    y = @last_move[1]
    symbol = @arr[x][y]
  
    # go down right
    i = x + 1
    j = y - 1
    no_of_consecutive = 1
    while i < 7 && j >= 0
      break if @arr[i][j] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i += 1
      j -= 1
    end
  
    # go up left
    i = x - 1
    j = y + 1
    while i >= 0 && j < 5
      break if @arr[i][j] != symbol
      no_of_consecutive += 1
      return true if no_of_consecutive >= 4
      i -= 1
      j += 1
    end
  
    false
  end

  def to_s
    <<-HEREDOC
   +---------------------------+
   | #{@arr[0][4]} | #{@arr[1][4]} | #{@arr[2][4]} | #{@arr[3][4]} | #{@arr[4][4]} | #{@arr[5][4]} | #{@arr[6][4]} |
   |---+---+---+---+---+---+---|
   | #{@arr[0][3]} | #{@arr[1][3]} | #{@arr[2][3]} | #{@arr[3][3]} | #{@arr[4][3]} | #{@arr[5][3]} | #{@arr[6][3]} |
   |---+---+---+---+---+---+---|
   | #{@arr[0][2]} | #{@arr[1][2]} | #{@arr[2][2]} | #{@arr[3][2]} | #{@arr[4][2]} | #{@arr[5][2]} | #{@arr[6][2]} |
   |---+---+---+---+---+---+---|
   | #{@arr[0][1]} | #{@arr[1][1]} | #{@arr[2][1]} | #{@arr[3][1]} | #{@arr[4][1]} | #{@arr[5][1]} | #{@arr[6][1]} |
   |---+---+---+---+---+---+---|
   | #{@arr[0][0]} | #{@arr[1][0]} | #{@arr[2][0]} | #{@arr[3][0]} | #{@arr[4][0]} | #{@arr[5][0]} | #{@arr[6][0]} |
   |---------------------------|
   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |   column #
   +---------------------------+
    HEREDOC
  end
end

# def to_s
#   <<-HEREDOC
#   #{@arr[0][4]} | #{@arr[1][4]} | #{@arr[2][4]} | #{@arr[3][4]} | #{@arr[4][4]} | #{@arr[5][4]} | #{@arr[6][4]}
#  ---+---+---+---+---+---+---
#   #{@arr[0][3]} | #{@arr[1][3]} | #{@arr[2][3]} | #{@arr[3][3]} | #{@arr[4][3]} | #{@arr[5][3]} | #{@arr[6][3]}
#  ---+---+---+---+---+---+---
#   #{@arr[0][2]} | #{@arr[1][2]} | #{@arr[2][2]} | #{@arr[3][2]} | #{@arr[4][2]} | #{@arr[5][2]} | #{@arr[6][2]}
#  ---+---+---+---+---+---+---
#   #{@arr[0][1]} | #{@arr[1][1]} | #{@arr[2][1]} | #{@arr[3][1]} | #{@arr[4][1]} | #{@arr[5][1]} | #{@arr[6][1]}
#  ---+---+---+---+---+---+---
#   #{@arr[0][0]} | #{@arr[1][0]} | #{@arr[2][0]} | #{@arr[3][0]} | #{@arr[4][0]} | #{@arr[5][0]} | #{@arr[6][0]}
#   HEREDOC
# end




