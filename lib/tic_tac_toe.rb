# Define your WIN_COMBINATIONS constant
# Define a constant in lib/tic_tac_toe.rb WIN_COMBINATIONS and
# set it equal to a nested array filled with the index values for the various win combinations in tic tac toe.
WIN_COMBINATIONS = [
  [0,1,2], # top row win
  [3,4,5], # middle row win
  [6,7,8], # bottom row win
  [0,3,6], # left column win
  [1,4,7], # middle column win
  [2,5,8], # right column win
  [0,4,8], # left diagonal win
  [2,4,6]  # right diagonal win
]

#DISPLAY_BOARD
#Define a method that prints the current board representation based on the board argument passed to the method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#INPUT_TO_INDEX
def input_to_index(user_input)
  user_input.to_i - 1
end

#MOVE
def move(board, index, current_player)
  board[index] = current_player
end

#POSITION_TAKEN?
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#VALID_MOVE?
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#TURN
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

#TURN_COUNT
# This method takes in an argument of the board array
# and returns the number of turns that have been played.
def turn_count(board)
  board.count{|e| e == "X" || e == "O"}

  # counter = 0
  # board.each do |e|
  #   if !full?(board)
  #     counter += 1
  #   end
  # end
  #
  # counter
end

#CURRENT_PLAYER
# The #current_player method should take in an argument of the game board
# and use the #turn_count method to determine if it is "X"'s turn or "O"'s.
# If the turn count is an even number, the #current_player method should return "X",
# otherwise, it should return "O".
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#WON?
def won?(board)
  WIN_COMBINATIONS.find do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

#FULL?
# The #full? method should accept a board and
# return true if every element in the board contains either an "X" or an "O".
def full?(board)
  board.all?{|e| e.upcase == "X" || e.upcase == "O" }
end

#DRAW?
# Build a method #draw? that accepts a board and
# returns true if the board has not been won and is full
# AND returns false if the board is not won and the board is not full,
# AND returns false if the board is won.
def draw?(board)
  !won?(board) && full?(board)
  # if !won?(board) && full?(board)
  #   # returns true if the board has not been won and is full
  #   true
  # elsif !won?(board) && !full?(board) || won?(board)
  #   #returns false if the board is not won and the board is not full
  #   # returns false if the board is won
  #   false
  # else
  #   false
  # end
end

#OVER?
# Build a method #over? that accepts a board and
# returns true if the board has been won,
# is a draw, or
# is full.
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#WINNER
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

#PLAY
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
