require "pry"

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6] # ETC, an array for each win combination
]
board = [" "," "," "," "," "," "," "," "," "]
# def display_board(board)
#   print "   |   |   \n-----------\n   |   |   \n-----------\n   |   |   \n"
# end
def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
 num = num.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  (board[index] == "" ||   board[index] == " " ||  board[index] == nil )?
   false : true
end

def valid_move?(board, index)
  (!position_taken?(board, index) && index.between?(0, 8))?
    true : false
end

def turn(board)
  # ask for input
  puts "Please enter 1-9:"
  # get input
  input = gets
  # convert input to index
    index = input_to_index(input)
  # if index is valid
  if (valid_move?(board, index))
    value = current_player(board)
    #   make the move for index
    move(board, index, value)
    #   show the board
    display_board(board)
  else
      turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
  if space == "X" || space == "O"
     count += 1
    end
  end
  count
end

def current_player(board)
  (turn_count(board) % 2 == 0 )?
  "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |i|
    #  binding.pry
    if  board[i[0]] == board[i[1]] && board[i[1]] == board[i[2]] && position_taken?(board, i[0])
      # binding.pry
      i
    end
  end
end

def full?(board)
  board.all? do |i|
     i == "X" || i == "O"
  end
end

def draw?(board)
 full?(board) && !won?(board)
end

def over?(board)
full?(board) || won?(board) || draw?(board)
end

def winner(board)
  winner_arr = won?(board)
  if winner_arr
    winner_index = winner_arr[1]
    board[winner_index]
  end
end

def play(board)

  # until the game is over
  until over?(board)
    #   take turns
    turn(board)
  end
  # if the game was won
  if won?(board)
    #   congratulate the winner
    puts "Congratulations #{winner(board)}!" #"Congratulations #{winner_index[0]}!" #

    # else if the game was a draw
  elsif draw?(board)
    #   tell the players it has been a draw
    puts "Cats Game!"
  end
end
