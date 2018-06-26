
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
    ]
    
def won?(board)
  WIN_COMBINATIONS.each do |win|
    if position_taken?(board, win[0]) == true && board[win[0]] ==  board[win[1]] && board[win[1]]== board[win[2]] && board[win[0]] == board[win[2]]
      return win
    end
  end
  return false
end

def full?(board)
  board.all? do |position| 
    position == "X" || position == "O"
  end
end

def draw?(board)
  if won?(board) == false
    return true
  elsif won?(board) == true
    return false
  end
end
  
def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  elsif won?(board) == false && full?(board) == false
    false
  elsif won?(board) == true
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    return board[win_combo[0]]
  end
end
