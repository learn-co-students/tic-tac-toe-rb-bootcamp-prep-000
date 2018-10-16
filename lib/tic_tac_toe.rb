def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end







def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


  
counter = 0
board.each do |turns|
 if turns == "X" || turns == "O"
  counter += 1
end
end
  
  return counter
end


def current_player(board)
  
  turn = turn_count(board)
  
  if turn.even?
    
    return "X"
  
else
  
  return "O"
  
end
end


WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
 
]

def won?(board)
  
  WIN_COMBINATIONS.find do |win_combination|
   win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  
   position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
  
   if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
end


end


 def full?(board)
  if board.any?{|i| i != "X" && i != "O"}
    return false
  elsif board.all?{|i| i != " "}
    return true
  end
end


 def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif won?(board) == false && full(board) == false
    return false
  else
    return false
  end
end


 def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end


 def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end