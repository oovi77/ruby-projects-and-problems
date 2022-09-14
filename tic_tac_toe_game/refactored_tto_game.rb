class Player
  def initialize(name, player_symbol)
    @name = name
    @player_symbol = player_symbol
  end

  attr_reader :name
  attr_reader :player_symbol
end

class Board < Player
  def initialize() # initialize to default empty board state, all blank statements
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def place_on_board(position, value)
    position = position.to_i
    if position >= board.length || position < 0
      p "Illegal position, out of bounds. Try again."
      return false
    elsif @board[position] != " "
      p "Illegal position, position already in use. Try again."
      return false
    else
      @board[position] = value
      p "Board changed to: "
      display_board
      return true
    end
  end

  protected

  attr_accessor :board # proctected so others can't change the board state

  public

  def change_board(board)
    @board = board
  end

  def full_board?
    count = 0
    board.each do |val|
      if val != " "
        count += 1
      end
    end

    if count == board.length
      return true
    else
      return false
    end
  end

  def display_board
    print "Board is: #{board}\n\n"
    count = 0

    board.each_with_index do |val, idx|
      count += 1
      print "|#{val}"
      if (count % 3 == 0)
        print "|\n"
        count = 0
      end
    end
  end

  def victory?
    game_completed = false
    if ((board[0] == board[1] && board[0] == board[2]) && board[0] != " ") # first row match
      p "1r"
      game_completed = true

    elsif ((board[3] == board[4] && board[3] == board[5]) && board[3] != " ") # second row
      p "2r"
      game_completed = true

    elsif (board[6] == board[7] && board[6] == board[8]) && board[6] != " " # third row
      p "3r"
      game_completed = true

    elsif (board[0] == board[3] && board[0] == board[6]) && board[0] != " " # first column
      p "1C"
      game_completed = true

    elsif (board[1] == board[4] && board[1] == board[7]) && board[1] != " " # 2nd column
      p "2C"
      game_completed = true

    elsif (board[2] == board[5] && board[2] == board[8]) && board[2] != " " # 3rd column
      p "3C"
      game_completed = true

    elsif (board[0] == board[4] && board[0] == board[8]) && board[0] != " " # first diagonal
      p "1dia"
      game_completed = true

    elsif (board[2] == board[4] && board[2] == board[6]) && board[2] != " " # 2nd diagonal
      p "2dia"
      game_completed = true
    else
      game_completed = false
      return game_completed
    end
  end
end

game_status = 1
p1_name = nil
p2_name = nil

p "Welcome to Tic-Tac-Toe "
p "----------------------"
puts ""

p "Player 1, please enter your name: "
p1_name = gets.chomp
p "Hello, #{p1_name}"
puts ""
p "Player 2, please enter your name: "
p2_name = gets.chomp
p "Hello, #{p2_name}"
puts ""

p1 = Player.new(p1_name, "X")
p2 = Player.new(p2_name, "O")
b1 = Board.new

p "#{p1_name} will be represented by: X on the board"
p "#{p2_name} will be represented by: O on the board"

p "Here is how the tic-tac-toe board looks like:"
b1.display_board
puts ""
p "And here is how positions on the board are represented from 0 to 8"
puts ""
p '|0|1|2|'
p '|3|4|5|'
p '|6|7|8|'
print "\n"

p1_turn_status = 1     # for player turns
p2_turn_status = 0
player_position = " "

while game_status == 1

  if b1.full_board?
    game_status = 0
    p1_turn_status = 0
    p2_turn_status = 0
    p "Tie game! Game Over."
  end

  while p1_turn_status == 1

    print "#{p1_name}'s turn, please enter a valid position on the board. Here is the current board state: "
    b1.display_board
    player_position = gets.chomp
    if b1.place_on_board(player_position, p1.player_symbol)
      player_position = " "
      if b1.victory?
        p "#{p1.name} wins! Game Over."
        p1_turn_status = 0
        p2_turn_status = 0
        game_status = 0
        break
      end
      p1_turn_status = 0
      p2_turn_status = 1
    end

  end

  while p2_turn_status == 1

    print "#{p2_name}'s turn, please enter a valid position on the board. Here is the current board state: "
    b1.display_board
    player_position = gets.chomp
    if b1.place_on_board(player_position, p2.player_symbol)
      player_position = " "
      if b1.victory?
        p "#{p2.name} wins! Game Over."
        p1_turn_status = 0
        p2_turn_status = 0
        game_status = 0
        break
      end
      p1_turn_status = 1
      p2_turn_status = 0
    end

  end

  if (b1.full_board? && game_status == 1)
    game_status = 0
    p1_turn_status = 0
    p2_turn_status = 0
    p "Tie game! Game Over."
  end

end
