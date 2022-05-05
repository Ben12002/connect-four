def initialize
  @board = Board.new
  @player_one = Player.new(1)
  @player_two = Player.new(2)
  @turn = 1
end

def play
  introduction
  turns
  game_results
end

def introduction
  puts "Welcome to connect-four. On each turn, please enter a number (0 - 6) corresponding to the column where you want to drop a piece."
  puts "Enter a character to use for player 1: "
  @player_one = create_character(1)

  puts "Enter a character to use for player 2. Cannot be #{@player_one.symbol} : "
  @player_two = create_character(2)
end


def turns
  until game_over?
    current_player = @turn.odd? ? @player_one : @player_two
    turn(current_player)
    display_board
    @turn += 1
  end
  
end

def game_results
  return "Player one wins!" if consecutive_four(@player_one.symbol)
  return "Player two wins!" if consecutive_four(@player_two.symbol)
  return "Draw!" if @board.full?
end

def create_character(num)
  symbol = get_symbol_input
  if num == 2
    if (symbol == @player_one.symbol)
      puts "please choose a different character: "
      create_character(num)
    else
      @player_two = Player.new(symbol, 2)
    end
  else
    @player_one = Player.new(symbol, 1)
  end
end

def get_symbol_input
  loop do
    answer = gets.chomp
    return answer if (answer.length == 1)
  end
  print "Please enter only 1 character.: "
end

def game_over?
  player_one_wins = consecutive_four(@player_one.symbol)
  player_two_wins = consecutive_four(@player_two.symbol)
  draw = @board.full?

  player_one_wins || player_two_wins || draw
end 

def turn(player)
  print player.to_s + "'s turn: "
  player_move = get_move_input
  move(player, player_move)
end

def get_move_input
  loop do
    player_move = gets.chomp
    return player_move.to_i if @board.valid_move?(player_move)
  end
  print "Please enter a valid move: "
end

def move(player, player_move)
  @board.add_to_board(player.symbol, player_move)
end

def display_board
  @board.display
end



