=begin

Purpose:

Build a tic-tac-toe game on the command line where two human players can
play against each other and the board is displayed in between turns.

=end


#board state will probably look like a 2D array
#actually, might be easier to just make the board a single array
# [1, 2, 3]
# [4, 5, 6]
# [7, 8, 9]

#board can look something like this
#can probably make a function to display the board better

=begin
temp_b = [["X", "", 3], ["O", "O", ""], ["", "", ""]]
p temp_b[0]
p temp_b[1]
p temp_b[2]
=end



#player class, needs a name, maybe a string
#representing what their symbol is on the board (like 'X' or 'O')

class Player

    def initialize(name, player_symbol)
        @name = name
        @player_symbol = player_symbol
    end

    attr_reader :name
    attr_reader :player_symbol

end

class Board 

    def initialize() #initialize to default empty board state, all blank statements
        @board = [" ", " ", " " , " ", " ", " " ," ", " ", " "] 
    end

    protected
    attr_accessor :board    #proctected so others can't change the board state

    # needs to take a single array that looks like this:
    # [["X", "", ""], ["O", "O", ""], ["", "", ""]]
    # and turn it into:
    # |X| | |
    # |O|O| |
    # | | | |

    public
    def change_board(board)
        @board = board
    end

    def display_board

        puts "Board is: #{board}"
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
    #here is what the board positions look like:
    #[0, 1, 2]
    #[3, 4, 5]
    #[6, 7, 8]
    #checks if there is a winner on the current game board, resulting in a victory

    #problem, victory? is trigerring on blank " " spaces, need to fix that - fixed!
    def victory?
        game_completed = false
        if ((board[0] == board[1] && board[0] == board[2]) && board[0] != " ") #first row match
            p "1r"
            game_completed = true
            
        elsif ((board[3] == board[4] && board[3] == board[5]) && board[3] != " ") #second row
            p "2r"
            game_completed = true
            
        elsif (board[6] == board[7] && board[6] == board[8]) && board[6] != " "  #third row
            p "3r"
            game_completed = true
            
        elsif(board[0] == board[3] && board[0] == board[6]) && board[0] != " " #first column
            p "1C"
            game_completed = true
            
        elsif(board[1] == board[4] && board[1] == board[7]) && board[1] != " " #2nd column
            p "2C"
            game_completed = true
            
        elsif(board[2] == board[5] && board[2] == board[8]) && board[2] != " " #3rd column
            p "3C"
            game_completed = true
            
        elsif(board[0] == board[4] && board[0] == board[8]) && board[0] != " " #first diagonal 
            p "1dia"
            game_completed = true
            
        elsif(board[2] == board[4] && board[2] == board[6]) && board[2] != " " #2nd diagonal 
            p "2dia"
            game_completed = true
        else
            game_completed = false
        return game_completed
        end
    end
end

#here is what the board positions look like:
#[0, 1, 2]
#[3, 4, 5]
#[6, 7, 8]

#tests for victory conditions for board
#To do, test all victory conditions...
b1 = ["X", " ", "O" , "O", "O", " " ," ", " ", " "]
second_d = [" ", " ", "O" , "O", "O", "X" ,"O", "X", " "]
first_d = ["O", " ", "O" , " ", "O", "X" ," ", "X", "O"]
b2 = [" ", " ", " " , "X", "O", " " ," ", "O", "X"]
sec_row = ["X", " ", "O" , "X", "X", "X" ," ", " ", " "]
board1 = Board.new()
board1.change_board(first_d)
board1.display_board
p board1.victory?

board1.change_board(second_d)
board1.display_board
p board1.victory?


board1.change_board(b2)
board1.display_board
p board1.victory?

board1.change_board(sec_row)
board1.display_board
p board1.victory?

#p tempb


#tests for creating a board and displaying a board
=begin
board1 = Board.new()
board1.display_board
board1.change_board(b1)
board1.display_board
=end



#tests for player class
=begin
jim = Player.new('Jim', 'X')
dweight = Player.new('Dweight', 'O')

p jim.name
p jim.player_symbol
p dweight.name
=end

