# March 31, 2018
# Laura Nadolski
# Flatiron Bootcamp - Intro to Ruby

# Tic Tac Toe
# A simple tic tac toe game coded in Ruby.

# Helper Methods

# #win_combinations is a nested array which contains all the possible combinations of wins.

WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Forward-slash diagonal
  [2, 4, 6], # Backward-slash diagonal
  ]

# #display_board accepts the board argument and prints the current board representation.

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# #input_to_index converts the user-inputted location of the desired move to the board index (player views spaces 1-9, whereas the corresponding array indeces are 0-8).

def input_to_index(user_input)
  user_input.to_i - 1
end

# #move accepts as arguments the board array, the user's desired index for their move, and the player's character of either "X" or "O."

def move(board, index, currentletter)
  board[index] = currentletter
end

# #position_taken? checks to see whether the space the user wants to play their move is already taken or not. Returns true if the position is indeed taken, or false if it is free.

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# #valid_move? accepts a board and an index. It returns true if the move is valid (present on the game board and not yet filled by another character) and false/nil if it is not.

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# #turn_count accepts a board as an argument and returns the number of turns already played.

def turn_count(board)
  counter = 0
  board.each do |movemade|
    if movemade == "X" || movemade == "O"
    counter += 1
    end
  end
  return counter
end

# #current_player accepts a board as an argument and determines whether it's "X"'s or "O"'s turn.

def current_player(board)
  turnnumber = turn_count(board)
  turnnumber.even? ? "X" : "O"
end

# #turn implements a full turn. It asks the user where they want to make their move, and if valid, it makes the move and displays the board. Else, it prompts the user for a new position until it receives a valid move.

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    letter = current_player(board)
    move(board, index, letter)
    display_board(board)
  else
      turn(board)
end

# #won? accepts a board as an argument and tests for whether or not the game has been won. If there is a win, it returns the winning character location indices. If no win has occured, it returns false/nil.

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    if ((board[wc[0]] == "X") && 
      (board[wc[1]] == "X") && 
      (board[wc[2]] == "X")) ||
      ((board[wc[0]] == "O") && 
      (board[wc[1]] == "O") && 
      (board[wc[2]] == "O"))
        return wc
    end
  end
  return false
end

# #full? accepts a board as an argument and returns true if the board is filled.

def full?(board)
  board.all? do |place|
    (place== "X") || (place == "O")
  end
end

# #draw? accepts a board as an argument and returns true if the board is full but has not been won. It returns false if the board is not yet full and no win has occured, or if the board has been won.

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

# #over? accepts a board as an argument and returns true if a win has occured, a draw has occured, or the board is full.

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

# #winner accepts a board as an argument and returns the winning character, given that the game has been won.

def winner(board)
  if won?(board)
    winnerchar = won?(board)
    return board[winnerchar[0]]
  else
    return nil
  end
end

# #play accepts a board as an argument and is responsible for the overall game loop. It activates turns while checking whether the game is over or not before ending the turns. When the game is in fact over, it then reports the game outcome.

def play(board)
  until over?(board) == true
    turn(board)
  end
  if over?(board)
    if won?(board)
      thewinner = winner(board)
      puts "Congratulations #{thewinner}!"
    else
      puts "Cat's Game!"
    end
  end
end
end