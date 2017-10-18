# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

#The method prints the current board representation
# based on the board argument passed to the method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# The method converts user_input to an integer
def input_to_index(user_input)
  user_input.to_i - 1
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
# The method places the move on the board
def move(board, index, current_player(board))
  board[index] = current_player
end
# The method evaluates the position selected against the Tic Tac Toe board
#  and check if it's occupied
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
#Checks and returns true if the move is valid and false or nil if not
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
# The method encapsulate the logic of a single complete turn composed
# of various routines
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    play = current_player(board)
    move(board, index, play)
    display_board(board)
  else
    turn(board)
  end
end
