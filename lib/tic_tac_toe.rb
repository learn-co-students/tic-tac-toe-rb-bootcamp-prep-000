# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # an array for each win combination
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Left top diagonal
  [2,4,6]   # Right top diagonal
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
  return board
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  !(board[index] == " " || board[index] == "" || board[index] == nil)
end

# code your #valid_move? method here
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip.to_i
  index = input_to_index user_input
  if valid_move? board, index
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# the player that goes first will be assigned the "X" token.
# If the turn count is an even number, the current_player method
# should return "X", otherwise, it should return "O".

def turn_count(board)
  counter = 0
  board.each do |slot|
    if slot == "X" || slot == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
 (turn_count(board).even?) ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| ["X", "O"].include?(token)}
end

def draw?(board)
  !won?(board) && full?(board) 
end

def over?(board)
 won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

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
