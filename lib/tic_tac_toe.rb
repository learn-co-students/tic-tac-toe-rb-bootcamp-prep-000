# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle
  [6,7,8], # Bottom
  [0,3,6], # Left Column
  [1,4,7], # Middle
  [2,5,8], # Right
  [0,4,8], # Falling Diag
  [2,4,6]  # Rising Diag
]

def iter_win_combination?(board, win_com)
  win_com.all? do |place|
    board[place] == position_taken?(board,index)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_com|
    if iter_win_combination?(board, token, win_com)
      win_comb
    else
      win_comb
    end
  end
end

def full?(board)
  if board.include?(" ") || board.include?("")
    false
  else
    true
  end
end

def draw?(board)
  if !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  won?(board).token
end


def display_board

end

def input_to_index(user_input)

end

def move(board,index,token)

end

def position_taken?()
  if condition

  else

  end
end

def valid_move?
  if condition

  end
end

def turn()

end

def turn_count(board)

end

def current_player(board)

end

def won?(board)

end

def full?(board)

end

def draw?(board)

end

def over?(board)

end

def winner(board)

end

def play(board)

end
