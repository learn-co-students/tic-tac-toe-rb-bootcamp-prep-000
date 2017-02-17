# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # LR diagonal
  [2,4,6]  # RL diagonal
  # ETC, an array for each win combination
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts the user input to the board index
def input_to_index(user_input)
  user_input.to_i - 1
end

# Places user's token in chosen board position
def move(board, position, token)
  board[position] = token
end

# Determines chosen position on the board is already taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Determines if the chosen move is valid
def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

# makes a valid move or asks for a input if position is invalid
def turn(board)
  token = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    puts "Invalid move"
    turn(board)
  end
end

# counts number occupied positions on the board
def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

# Determines whose turn it is
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Determines if the game has been won
def won?(board)
won = false
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[0])
  end
end

# Determines if they board is full
def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

# Determines if the game was a draw
def draw?(board)
  !won?(board) && full?(board)
end

# determines if the game is over
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

# Returns value of winning token
def winner(board)
  if !won?(board)
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end


def play(board)
  #3.times do
  #  turn(board)
  #end
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
