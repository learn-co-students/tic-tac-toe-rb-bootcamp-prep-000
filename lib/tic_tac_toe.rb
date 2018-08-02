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
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  now_you = current_player(board)
  if valid_move?(board, index)
    move(board, index,now_you)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
 until over?(board) do
   turn(board)
 end
 if won?(board)
   will=winner(board)
   puts "Congratulations #{will}!"
 elsif draw?(board)
  puts "Cat's Game!"
end
end

def turn_count(array)
  occupied_spaces=0
  array.each do |turn|
    if (turn=="X") || (turn=="O")
     occupied_spaces+=1
   else NIL
 end
 end
return occupied_spaces
end 

def current_player(array)
  total=turn_count(array)
  if total%2==1
    return "O"
  elsif total%2==0 || total==0
    return "X"
  end
end

WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)
  if (board[0]=="X" && board[1]=="X" && board[2]=="X")||(board[0]=="O" && board[1]=="O" && board[2]=="O")
    return WIN_COMBINATIONS[0]
    
  elsif (board[3]=="X" && board[4]=="X" && board[5]=="X")||(board[3]=="O" && board[4]=="O" && board[5]=="O")
    return WIN_COMBINATIONS[1]
  
  elsif (board[6]=="X" && board[7]=="X" && board[8]=="X")||(board[6]=="O" && board[7]=="O" && board[8]=="O")
    return WIN_COMBINATIONS[2]
  
  elsif (board[0]=="X" && board[3]=="X" && board[6]=="X")||(board[0]=="O" && board[3]=="O" && board[6]=="O")
    return WIN_COMBINATIONS[3]
  
  elsif (board[1]=="X" && board[4]=="X" && board[7]=="X")||(board[1]=="O" && board[4]=="O" && board[7]=="O")
    return WIN_COMBINATIONS[4]
  
  elsif (board[2]=="X" && board[5]=="X" && board[8]=="X")||(board[2]=="O" && board[5]=="O" && board[8]=="O")
    return WIN_COMBINATIONS[5]
  
  elsif (board[0]=="X" && board[4]=="X" && board[8]=="X")||(board[0]=="O" && board[4]=="O" && board[8]=="O")
    return WIN_COMBINATIONS[6]
  
  elsif (board[6]=="X" && board[4]=="X" && board[2]=="X")||(board[6]=="O" && board[4]=="O" && board[2]=="O")
    return WIN_COMBINATIONS[7]
  else
    return FALSE
  end
end

def full?(board)
  board.all?{|number| number=="X"||number=="O"} 
end

def draw?(board)
  if full?(board) && !won?(board)
    TRUE
  else
    FALSE
end
end

def over?(board)
  if draw?(board) || (full?(board) && won?(board)) || (!full?(board) && won?(board))
    TRUE
  else
    FALSE
  end
end

def winner(board)
  if got = won?(board)
    return board[got.first]
  end
end
