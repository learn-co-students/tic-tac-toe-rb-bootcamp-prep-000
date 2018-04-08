require "pry"
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} 
-----------
 #{board[3]} | #{board[4]} | #{board[5]} 
-----------
 #{board[6]} | #{board[7]} | #{board[8]} "
  
end

def input_to_index(index)
  index = index.to_i - 1
end 

def position_taken?(board,index)
  if (board[index] == "X" || board[index] == "O")
    return true 
  else 
    return false
  end
end

def valid_move?(board, index)
 if   index.between?(0,8) && (board[index] == " " || board[index] == "")
 return true 
 else 
 return false
 end
end 

def move(board, index, char) 
  board[index.to_i] = char
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  char = current_player(board)
  until valid_move?(board,index) == true
  puts"Not a valid move. Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  end
  move(board,index,char)
  display_board(board)
end 

def turn_count(board)
  count =0
  board.each do |turn| 
    if turn == "O" || turn == "X" 
      count += 1 
    end
  end
    return count

end

def current_player(board)
  if turn_count(board)% 2 == 0 
    return "X"
  elsif turn_count(board)% 2 == 1 
    return "O"
  else 
    return "Error"
  end
end

WIN_COMBINATIONS = [[0,1,2], [3,4,5] ,[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |place|
   
    win1 = place[0]
    win2 = place[1]
    win3 = place[2]
    
    win_char1 = board[win1]
    win_char2 = board[win2]
    win_char3 = board[win3]
    
    if (win_char1 == "X" && win_char2 =="X" && win_char3 == "X")||(win_char1 == "O" && win_char2 =="O" && win_char3 == "O")
      return place
      end
  end 
  return false
end 


def full?(board)
    board.each do |check|
      if check == "" || check == " "  || check == nil
      return false
      end
    end
    return true
end

def draw?(board)
   !won?(board) &&full?(board)   
end 


def over?(board)

  if won?(board)  || draw?(board) 
  return true
  end
 return false
end

def winner(board)
  if over?(board) == true && draw?(board) == false
  
    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"
    return "O"
    end 
  end
end 

def play(board) 
 puts "Welcome to tic tac toe" 
 display_board(board)
 until over?(board) 
 turn_count(board)
 turn(board)
 end
if draw?(board) 
       puts "Cats Game!"
 elsif winner(board) == "X"
       puts "Congratulations X"
 elsif winner(board) == "O"
       puts "Congratulations O"
   end
end 
