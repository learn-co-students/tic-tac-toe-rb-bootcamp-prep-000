WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

# Helper methods
# Checks whether a position is taken, returns true if it is.
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

# Method for user's turn
def turn(board)
  puts "Please enter 1-9:"
  current_player = current_player(board)
  player_move = input_to_index(gets.strip)
  if valid_move?(board, player_move)
    do_move(board, player_move, current_player)
    display_board(board)
  else
    turn(board)
  end
end

# Plays a move, knowing the board, the position wanted, and the player's character
def do_move(board, position, char = "X")
  board[position] = char
end

# Checks if the desired move is valid
def valid_move?(board, index)
  !position_taken?(board, index) && index <= board.length - 1
end

# Check whether we have a winning combination. Returns the winning combination, or nil if there's none
def won?(b)
  win_comb = nil
  WIN_COMBINATIONS.each do |c|
    if (b[c[0]] == "X" || b[c[0]] == "O") && (b[c[0]] == b[c[1]] && b[c[1]] == b[c[2]]) # b = board and c = combination
      win_comb = c
    end
  end
    win_comb
end

# Checks whether the board is full. Returns true if it is.
def full?(board)
  !(board.any?{|e| e == ""} || board.any?{|e| e == " "})
end

# Checks whether there's a draw. Returns true if there is.
def draw?(board)
  status = false
  if !won?(board) & full?(board) # true means a draw because the board is not won but full
    status = true
  elsif !won?(board) & !full?(board) || won?(board) # false means a draw if the board is neither full nor won, or if the board is won
    status = false
  end
  status
end

# Checks whether the game is over. Returns true if it is.
def over?(board)
  won?(board) != nil || draw?(board) || full?(board)
end

# to be called when won?(board) is true to determine who's the winner.
def winner(board)
  winner = won?(board) # e.g [0,1,2]
  if winner != nil
    winner = board[winner[0]]
  end
  winner
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  line_1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  divider = "-----------"
  line_2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  line_3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts line_1, divider, line_2, divider, line_3
end

# Converts user input into an index for placement on the board
def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

# Determines how many turns have been played
def turn_count(board)
  plays = 0
  board.each do |place|
    plays +=1 if (place == "X" || place == "O")
    end
  return plays
end

# Determine whose turn it is, using turn_count
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  winner = nil
  display_board(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end
