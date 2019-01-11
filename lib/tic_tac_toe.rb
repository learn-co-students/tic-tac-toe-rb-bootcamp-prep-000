def display_board(board)
   puts" #{board[0]} | #{board[1]} | #{board[2]} "
   puts"-----------"
   puts" #{board[3]} | #{board[4]} | #{board[5]} "
   puts"-----------"
   puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

    
def input_to_index(input)
  index = input.to_i - 1
end


def move(board, index, value = "X")
  board[index] = value
end


def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end


def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    return true
  end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left diagonal
  [2,4,6], # Right diagonal
  ]
  

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1] 
    position_2 = board[win_index_2] 
    position_3 = board[win_index_3] 
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif 
      position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
  if false
    return false
  end
  #binding.pry
end
    
def full?(board)  
  if board.include? " "
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) && !won?(board) 
    true
  elsif won?(board)
    false
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end
 
 
def winner(board)
  if won?(board)
    board[won?(board)[0]]
  elsif !won?(board)
    nil
  end
end
