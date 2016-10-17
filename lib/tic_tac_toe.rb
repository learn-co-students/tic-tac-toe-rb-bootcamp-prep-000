require 'pry'
# Defines a constant WIN_COMBINATIONS with arrays for each win combination.
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Prints arbitrary arrangements of the board
def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  # converts a user_input to an integer
  input = user_input.to_i
  # subtracts 1 from the user_input, returns -1 for strings without integers
  index = input - 1
  # user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

# Returns true/false based on position in board
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

# Returns true/false based on position
def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do | move |
    # if one of the move is "X" or "0" play the game
    if move == "X" || move == "O"
      count += 1
      #   board.count {|token| token == "X" || token == "O"}
    end
  end
  return count
end

def current_player(board)
  # if the turn is even
  if turn_count(board) % 2 == 0
    # returns the correct player, X
    return "X"
  else
    # if it's odd returns the correct player, O
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board, win_combination[0])
  end
end

# returns true for a draw, false for an in-progess game
def full?(board)
  board.all? do | player_char|
    player_char == "X" || player_char == "O"
  end
end

# Returns true for a draw, false for a gne in the first row, won game diagonaly & for an in-progress game.
def draw?(board)
  return !won?(board) && full?(board)
end

# Returns true for a draw and for a won game flase for an in-progress game
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# return X when X won, O when O won and return Nil when no winner.
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
