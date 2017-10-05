# set up winning combinations
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # 1st column
  [1,4,7], # 2nd column
  [2,5,8], # 3rd column
  [0,4,8], # diagonal top left to bottom right
  [2,4,6]  # other diagonal!
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5] } "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8] } "
end

#convert user input into number to be used as index
def input_to_index(input)
  input = input.to_i - 1
end

# make a move, player previously defaults to X if doesn't choose
def move(board, move, player)
  board[move] = player
end

# checks whether there is something already at a position
def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

# checks whether the position input is allowed and whether it is not already occupied
def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    true
  else false
  end
end

# gives the player a turn
def turn(board)
  player = current_player(board) # asssume player is X
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  while !valid_move?(board,index) do
    input = gets.strip
    index = input_to_index(input)
  end
  move(board,index,player)
  display_board(board)
end

# count no. of turns from board
def turn_count(board)
  count = 0
board.each do |index|
if index == "X" || index =="O"
  count += 1
end
end
return count
end

# calculate whose turn it is from no. of turns taked (turn_count)
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#calculate whether there has been a winner
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    pos1 = combination[0]
    pos2 = combination[1]
    pos3 = combination[2]
    if (board[pos1] == "X" && board[pos2] =="X" && board[pos3] =="X") || (board[pos1] == "O" && board[pos2] =="O" && board[pos3] =="O")
      return combination
    end
    end
    return false # because will only get here if have not "returned" due to finding a win combination
  end

# calclate whether the board is full
def full?(board)
  board.all?{|i| i == "X" || i =="O"}
end

# calculate whether the game was a draw
def draw?(board)
  full?(board) && !won?(board)
  end

# calculate whether the game has finished
def over?(board)
  won?(board) || draw?(board) ||full?(board)
end

# calculate who the winner is
def winner(board)
  winning_player = won?(board)
  if winning_player == false
    return nil
  else board[winning_player[0]] # simply access the first element of the winning combination
  end
end

# determine/calculate which player won
def winner(board)
  winning_player = won?(board)
  if winning_player == false
    return nil
  else board[winning_player[0]] # simply access the first element of the winning combination
  end
end

# main loop for playing the game
def play(board)
  until over?(board)
    turn(board)
  end
# check for winner
if winner(board)
  winner = winner(board)
  puts "Congratulations #{winner}!"
elsif draw?(board)
puts "Cat's Game!"
end
end
