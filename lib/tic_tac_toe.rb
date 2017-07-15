# Constant (winning combinations).
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # bottom row
  [0,3,6], # left vertical row
  [1,4,7], # middle vertical row
  [2,5,8], # right vertical row
  [0,4,8], # 1st diagonal row
  [2,4,6]  # 2nd diagonal row
]

# method to display the current board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# method which converts player's input to the board index
def input_to_index(user_input)
  user_input.to_i - 1
end

# method which checks whether or not index on the board array is occupied.
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# method which checks and returns 'true' if the move is valid.
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# method which displays player's move.
def move(board, index, current_player)
  board[index] = current_player
  display_board(board)
end

# method which determines if it is "X"'s turn or "O"'s.
def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
  return current_player
end

# method which encapsulates the logic of a single complete turn.
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    puts "Invalid number! The spot is taken."
    turn(board)
  end
end

# method which returns the number of turns that have been played.
def turn_count(board)
  counter = 0
  board.each do |rounds|
    if rounds == "X" || rounds == "O"
      counter += 1
    end
  end
  return counter
end

# method which return 'false/nil' if there is no win, or
# return the winning combination indexes as an array if there is a win.
def won?(board)
  if !board.all? {|empty| empty == " " || empty == ""}
    WIN_COMBINATIONS.detect do |win_combination|
      position_1 = board[win_combination[0]]
      position_2 = board[win_combination[1]]
      position_3 = board[win_combination[2]]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
      end
    end
 else
   return false
 end
end

# method which returns true if every element in the board
# contains either an "X" or an "O".
def full?(board)
  if board.include?(" ") || board.include?("") || board.include?(nil)
    return false
  else
    return true
  end
end

# method which returns true if it's a draw.
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

# method which returns 'true' if the board has been won, is a draw, or is full.
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

# method which return the token, "X" or "O" that has won the game.
def winner(board)
  if won?(board)
    winner = won?(board)[0]
    return board[winner]
  else
    return nil
  end
end

# the main method of the tic tac toe application
# which is responsible for the game loop and outcome of the game.
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
