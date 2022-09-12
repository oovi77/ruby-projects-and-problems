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

    def initialize(board)
        @board = board
    end

    attr_accessor :board

    # needs to take a single array that looks like this:
    # [["X", "", ""], ["O", "O", ""], ["", "", ""]]
    # and turn it into:
    # |X| | |
    # |O|O| |
    # | | | |

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
end

tempb = temp_b = ["X", " ", "O" , "O", "O", " " ," ", " ", " "]
#p tempb
board1 = Board.new(tempb)
board1.display_board
print "a"
print "b"

#tests for player class
=begin
jim = Player.new('Jim', 'X')
dweight = Player.new('Dweight', 'O')

p jim.name
p jim.player_symbol
p dweight.name
=end

