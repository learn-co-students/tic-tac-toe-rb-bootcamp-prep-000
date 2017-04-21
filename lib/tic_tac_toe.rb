# Helper Methods

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # TOP ROW
  [3,4,5], # MIDDLE ROW
  [6,7,8], # BOTTOM ROW
  [0,3,6], # FIRST COLUMN
  [1,4,7], # MIDDLE COLUMN
  [2,5,8], # LAST COLUMN
  [0,4,8], # DIAGONAL TOP LEFT, BOTTOM RIGHT
  [2,4,6]  # DIAGONAL TOP RIGHT, BOTTOM LEFT
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(game_board)
  puts " #{game_board[0]} | #{game_board[1]} | #{game_board[2]} "
  puts "-----------"
  puts " #{game_board[3]} | #{game_board[4]} | #{game_board[5]} "
  puts "-----------"
  puts " #{game_board[6]} | #{game_board[7]} | #{game_board[8]} "
end

# Converts players requested move from a
# string to an Interger
# Subtracts 1 from that input for use as
# an Index to select the board array
# position
def input_to_index(user_input)
 user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

# Checks if position contains "X" or "O"
# if so, return true
# if not, return false
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# is players requested move position Valid?
# if so, true
# if not, false
def valid_move?(board, index)
  if  index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def moveRequest
  puts "Please enter 1-9 for your move:"
  index = input_to_index(gets.strip)
end

def turn(board)
  value = current_player(board)
  index = moveRequest
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    turn == "X" || turn == "O" ? counter += 1 : next
  end
   counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect { |combo|
    if position_taken?(board, combo[0])
      board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" || board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
    end
}
end

def full?(board)
  board.all?{ |move| move != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
 won?(board) || draw?(board)
end

def winner(board)

  if won?(board)
    winning_combo = won?(board)
    if board[winning_combo[0]] == "X"
      "X"
    elsif board[winning_combo[0]] == "O"
      "O"
    end
  end

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
