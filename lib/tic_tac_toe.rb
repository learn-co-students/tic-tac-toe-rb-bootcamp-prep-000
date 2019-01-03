WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
number.to_i - 1
end

def move(board, input_to_index, player)
board[input_to_index] = player
return board
end

def position_taken?(board,index)
  if ((board[index] == "X") || (board[index] == "O"))
    return true
  else
  return false
  end
end

def valid_move?(board, index)
  if index == nil || index < 0 || index > 8
    false
  elsif position_taken?(board, index)
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  valid = valid_move?(board, input)
  if valid == true
    move(board, input, current_player(board))
    display_board(board)
  else
    puts "please enter 1-9:"
    input = gets.strip
   end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
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
   if board.detect {|i| i == " " || i == nil}
    return false
  else return true
  end
end

def draw?(board)
  if (full?(board) && !won?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if (full?(board) || won?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end

def play(board)
  while !over?(board)
    current_player(board)
    turn(board)
  end
    if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
  
end
