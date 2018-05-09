#c onstant win combination definition
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Bottom column
  [0,4,8], # From left diag
  [2,4,6] # From right diag
  ]

# define board displaying method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# convert the user move to index
def input_to_index(user_input)
  user_input.to_i - 1
end

# put user's move and value into the board
def move(board, position, value)
  board[position] = value
end

# check if position taken
def position_taken?(board, position)
  !(board[position] ==  " " || board[position] == nil)
end

# check if move is valid
def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end

# define turn logic
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
  valid_move?(board, position) ? move(board, position, value = current_player(board)) && display_board(board) : turn(board)
end

# define turn's counter
def turn_count(board)
  board.count { |x| x == "X" || x == "O" }
end

# define who's turn is next
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# define who won
def won?(board)
  WIN_COMBINATIONS.find { |win| board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] && board[win[0]] != " "}
end

# define if board is full of X and O
def full?(board)
   return board.all? { |value| value == "X" || value == "O"}
end

# define if its a draw
def draw?(board)
  !won?(board) && full?(board) ? true : false
end

# true if won, is a draw, or is full
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# return the token, "X" or "O" that has won
# return the token, "X" or "O" that has won
def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

# main method of the tic tac toe application
def play(board)
    while !over?
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end