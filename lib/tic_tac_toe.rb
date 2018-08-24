  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],[0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]
    ]
   
def won?(board)
  WIN_COMBINATIONS.each do |combo| 
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
     end 

    if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end 
  end
  return false 
end

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


def move (board, index, character)
  board[index] = character 

end 

def position_taken?(board,index)
  if board [index] == " " || board [index] == "" || board [index] == nil
  return false
  
  elsif board [index] == "X" || board [index] == "O"
  return true 
end 
end 

def valid_move?(board,index)

if index.between?(0,8) && !position_taken?(board, index)

return true 

end 
end 

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
index = input_to_index(user_input)   
  
  
 if valid_move?(board,index) 
   move(board, index, current_player(board))
    display_board(board)

else    
   turn(board) 
   
   
end
end 

def turn_count(board)
  counter = 0 
  board.each do |space|
    if space == "X" || space == "O"
      counter +=1
    end 
end
counter 
end 

def current_player(board)
if turn_count(board) % 2 == 0 
  "X"
else 
  "O"
  end 
end 

def full?(board)

board.all?{|space|  space == "X" || space == "O"}

 
end

def draw?(board)

 full?(board) && !won?(board)
end  

def over?(board)
 
 draw?(board) || won?(board) && full?(board) || won?(board) && !full?(board)
 
end 

def winner(board)

  combo = won?(board)
  if won?(board) && board[won?(board)[0]] == "X" 
    return board[won?(board)[0]]
   
  elsif won?(board) && board[won?(board)[0]] == "O"     
    return board[won?(board)[0]]

  else 
    return nil
  end
end 

def play(board)
   
while !over?(board) 
turn(board)

end
if won?(board)
  puts "Congratulations #{winner(board)}!"
  
 elsif draw?(board)
puts  "Cat's Game!" 
 
end
end