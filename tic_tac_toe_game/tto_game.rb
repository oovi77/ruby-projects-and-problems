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

class Board < Player

    def initialize() #initialize to default empty board state, all blank statements
        @board = [" ", " ", " " , " ", " ", " " ," ", " ", " "] 
    end

    #function that allows a player to place an X or O on the board in their desired position
    #return true if position is valid, false otherwise?
    def place_on_board(position, value)
        if position >= board.length || position < 0
            p "Illegal position, out of bounds."
            return false
        elsif @board[position] != " "
            p "Illegal position, position already in use."
            return false
        else
            @board[position] = value
            p "Board changed to: "
            display_board
            return true
        end
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

#Main loop where players will take their turns

#name = gets.chomp

=begin
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
p'|0|1|2|'
p'|3|4|5|'
p'|6|7|8|'
print "\n"

p1_turn_status = 1     #for player turns
p2_turn_status = 0 
player_position = " " 

#forgot about if there are no winners, ie, the board being full
#potential fix #1, change victory? to output , 1, 0, or -1 instead of true, false
#potential fix #2, create new function to check if board is full

while game_status == 1

    while p1_turn_status == 1

        print "#{p1_name}'s turn, please enter a valid position on the board. Here is the current board state: "
        b1.display_board
        player_position = gets.chomp
        if place_on_board(player_position, p1.player_symbol)
            player_position = " "
            if b1.victory? 
                p "#{p1.name} wins! Game Over."
                p1_turn_status = 0
                game_status = 0
            end
            p1_turn_status = 0
            p2_turn_status = 1
        end

    end



end
#end of main loop, where players take their turns

=end

#tests for full_board?

=begin
b1 = ["X", " ", "O" , "O", "O", " " ," ", " ", " "]
second_d = [" ", " ", "O" , "O", "O", "X" ,"O", "X", " "]
first_d = ["O", " ", "O" , " ", "O", "X" ," ", "X", "O"]
b2 = [" ", " ", " " , "X", "O", " " ," ", "O", "X"]
sec_row = ["X", " ", "O" , "X", "X", "X" ," ", " ", " "]
almost_b = ["X", "X", "O" , "X", "X", "X" ,"X", "O", " "]
full_b = ["X", "X", "O" , "X", "X", "X" ,"X", "O", "X"]
board1 = Board.new()
board1.change_board(first_d)
p board1.full_board?
board1.change_board(second_d)
p board1.full_board?
board1.change_board(sec_row)
p board1.full_board?
board1.change_board(almost_b)
p board1.full_board?
board1.change_board(full_b)
p board1.full_board?
=end




#tests for place_on_board(position, value)

=begin
b1 = ["X", " ", "O" , "O", "O", " " ," ", " ", " "]
second_d = [" ", " ", "O" , "O", "O", "X" ,"O", "X", " "]
first_d = ["O", " ", "O" , " ", "O", "X" ," ", "X", "O"]
b2 = [" ", " ", " " , "X", "O", " " ," ", "O", "X"]
sec_row = ["X", " ", "O" , "X", "X", "X" ," ", " ", " "]
board1 = Board.new()
board1.change_board(first_d)
board1.display_board
p board1.place_on_board(0, "X")

p "------TESTING--------"
for i in -2 .. 10
    p "testing #{i}"
    p board1.place_on_board(i, "X")
end
p "end of test"
board1.display_board
=end


#tests for victory conditions for board
#To do, test all victory conditions...

=begin
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
=end




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

