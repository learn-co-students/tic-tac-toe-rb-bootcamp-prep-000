def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, current_player)
  board[index] = current_player
  return board
  
end


def position_taken?(board, index)
  
 if !(board[index] == " " || board[index] == "" || board[index] == nil)
   
   return true
 else
  return false
 end 
end


def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    
    puts "That move was not vaild please try again"
    turn(board)
  end
end


def turn_count(board)
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
  [0,1,2],
  [3,4,5], 
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
  if won?(board)
    return false
  elsif full?(board)
    return true
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
  
def play(board)

  until over?(board)
    turn(board)
    
  end
  
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
 end
 