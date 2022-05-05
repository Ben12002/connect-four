# I asked a question about TDD here:
# https://discord.com/channels/505093832157691914/543074220691947531/960639035204853800

class Game

  attr_reader :board, :player_one, :player_two

  def initialize
    @board = Board.new
    @turn = 1
  end

  def play
    set_up_game
    turns
    game_results
  end

  def set_up_game
    introduction_message
    create_characters
  end

  def introduction_message
    puts <<-HEREDOC
    --------------------------------------------------------------------------------------------------------------------------------
          Welcome to connect four. First enter a character you would like to use as your player marker.
          To move, enter a number between 1 and 7, corresponding to the column which you would like to drop a piece.
    --------------------------------------------------------------------------------------------------------------------------------      
          HEREDOC
  end

  def create_characters
    print "Enter a character to use for player 1: "
    symbol_one = get_symbol_input
    @player_one = Player.new(1, symbol_one)

     # loop do doesn't work, since blocks have different scope. then Player.new won't have access to symbol_two.
    while true
      print "Enter a character to use for player 2: "
      symbol_two = get_symbol_input
      break if (symbol_two != symbol_one)
      print 'Please enter a different character: '
    end
    @player_two = Player.new(2, symbol_two)
  end

  def get_symbol_input
    loop do
      answer = gets.chomp
      return answer if answer.length == 1
      print 'Please enter only one character: '
    end
  end

  def turns
    loop do
      current_player = @turn.odd? ? @player_one : @player_two
      turn(current_player)
      return if game_over?
      @turn += 1
    end
  end

  def turn(player)
    print player.to_s + "'s turn: "
    player_move = get_move_input
    @board.add_to_board(player_move, player.symbol)
    puts @board
  end

  def get_move_input
    loop do
      answer = gets.chomp
      return (answer.to_i - 1) if @board.valid_move?(answer)
      print 'Please enter a valid move: '
    end
  end

  def game_results
    return puts "Player one wins!" if @board.consecutive_four?(@player_one.symbol)
    return puts "Player two wins!" if @board.consecutive_four?(@player_two.symbol)
    return puts "Draw!" if @board.full?
  end

  def game_over?
    player_one_wins = @board.consecutive_four?(@player_one.symbol)
    player_two_wins = @board.consecutive_four?(@player_two.symbol)
    draw = @board.full?
    player_one_wins || player_two_wins || draw
  end

end
