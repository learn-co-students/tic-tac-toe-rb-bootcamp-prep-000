
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
 
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [2,4,6],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]
  
def input_to_index(user_input)
  user_input.to_i - 1
   end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
  end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
  end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board) 
  # iterate over the board and see if there's a winning combo, if not return false
  WIN_COMBINATIONS.each do |win_combo|
  if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]]== "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
     return win_combo
    end
    end
    return false
end


def turn_count(board)
  
  counter=0
 board.each do |turn|
   if turn == 'X' || turn == 'O'
     counter += 1
end
end
counter
end

def current_player(board)
  turn_count(board)%2 == 0 ? 'X' : 'O'
  end
  
  def move(board, index, player)
  board[index] = player
  # turn_count(board)
  # display_board(board)
end

def full?(board)
 board.all? do |letter|
    letter == "X" || letter == "O"
  end
  end



def draw?(board)
  full?(board) && !won?(board)
  end


def over?(board)
  won?(board) || draw?(board) || full?(board) 
  end



def winner(board)
  if won?(board)
     board[won?(board)[0]]
  end
end

def play(board)
  
until over?(board)
turn(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
  puts "Cat's Game!"
end
end
