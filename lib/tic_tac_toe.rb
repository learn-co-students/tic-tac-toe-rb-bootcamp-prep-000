WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #left diagonal
  [2, 4, 6]  #right diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  if board[position] == " "
    return false
  elsif (board[position] == "X" || board[position] == "O")
    return true
  end
end

def valid_move?(board, postion)
  if (!position_taken?(board, position))
    return true
  else
    return false
  end
end
