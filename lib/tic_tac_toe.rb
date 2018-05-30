WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # First column
  [1, 4, 7], # Second column
  [2, 5, 8], # Third Column
  [0, 4, 8], # Left to Right diagonal
  [2, 4, 6]  # Right to Left diagonal
] #This is the array containing all of the winning combinations of moves

##
# This method displayes the board to the user with the given array of the state of the board
##
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

##
# This method takes in the user input, converts it to an integer then subtracts 1
# to make it mirror the index of the array
##
def input_to_index(input)
  return placement = input.to_i - 1
end

##
# This method takes the board, index the player wants to use, and the token of the
# player and makes the move on the board
##
def move(board, index, character)
  board[index] = character
  return board
end

##
# This method takes the board and the desired index and checks to ensure the desired
# index is not already taken
##
def position_taken?(board, index)
  if(board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  else
    return true
  end
end

##
# This method takes the board and index to check if the desired move is a valid one.
# A valid move has an index between 0-8 and is not in a position that is already taken.
##
def valid_move?(board, index)
  return index.between?(0, 8) && !position_taken?(board, index) ? true : false;
end

##
# This method takes in the current state of the board and asks
# the player to make a selection for where they want to move.
# It takes their selection and ensures the move is valid before
# initiating the move and displaying the board. If the move is
# not valid it will simply ask them for a new move.
##
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

##
# This move checks the board for filled slots to determine how many
# moves have already been taken.
##
def turn_count(board)
  counter = 0;
  board.each do |slot|
    if(slot == "X" || slot == "O")
      counter += 1;
    end
  end
  return counter;
end

##
# This method uses #turn_count to determine who's turn it is.
##
def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O";
end

##
# This method checks if someone has won the game by iterating through
# the WIN_COMBINATIONS and checking the board against the combinations.
# If a player has won it returns the combination that won the game, Otherwise
# it returns false/nil
##
def won?(board)
  x = "X";
  o = "O";

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0];
    win_index_2 = win_combination[1];
    win_index_3 = win_combination[2];

    position_1 = board[win_index_1];
    position_2 = board[win_index_2];
    position_3 = board[win_index_3];

    if ((position_1 == x && position_2 == x && position_3 == x) ||
      (position_1 == o && position_2 == o && position_3 == o))
        return win_combination;
      else
        false
    end
  end
  return false;
end

##
# This method checks to see if the board is full
##
def full?(board)
  return board.detect{|i| i == " "} ? false : true
end

##
# This method checks the board for a tie/draw
##
def draw?(board)
  return full?(board) && !won?(board) ? true : false
end

##
# This method checks the board to see if there is a winner or a draw, so
# that the game may end.
##
def over?(board)
  return won?(board) || draw?(board) ? true : false
end

##
# This method checks to determine who the winner is and returns that player's token
##
def winner(board)
  winner = won?(board)
  return won?(board) == false ? nil : board[winner[0]]
end

##
# This method starts the game process
##
def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
