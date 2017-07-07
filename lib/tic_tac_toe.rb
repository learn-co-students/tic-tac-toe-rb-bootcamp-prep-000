WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # First row
  [1, 4, 7], # Second row
  [2, 5, 8], # Third row
  [0, 4, 8], # Top-left to Bottom-right diagonal
  [2, 4, 6] # Top-right to Bottom-left diagonal
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

# Return true if the position is taken by X or O. False if it's empty.
def position_taken?(board, index)
   !(board[index] ==  " " || board[index] == "" || board[index] == nil)
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
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

# Create an array of X's and O's and find the length
def turn_count(board)
  board.select{|i| i == "X" || i == "O"}.length
end

def current_player(board)
  if (turn_count(board) + 1) % 2 == 1 then "X" else "O" end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.none?{|i| i == " " || i == nil}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board) then board[won?(board)[0]] end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
