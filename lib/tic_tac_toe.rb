WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  new_user_input = user_input.to_i
  new_user_input -= 1
  return new_user_input
end

def move(board, location,player)
  board[location] = player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
  # Creates a stop on RSpec
  # !(board[location].nil? || board[location] == "")
end

def valid_move?(board,index)
  if index.to_i.between?(1,9) && !position_taken?(board, index.to_i-1)
    return true
  else false
  end
end