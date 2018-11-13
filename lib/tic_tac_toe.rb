WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  
  def display_board(board)
  
  puts " #{board[0]} | #{board[1]} | #{board[2]} " 
  puts "-----------" 
  puts " #{board[3]} | #{board[4]} | #{board[5]} " 
  puts "-----------" 
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  index
end
 
 def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
     return true
  else
   return false
  end
end


 def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    char = current_player(board)
    if valid_move?(board, index)
      move(board, index, char)
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  counter = 0
  
 board.each do |turns|
   unless turns == " "
     counter += 1
   end
  end
 return counter
 end
 
 def current_player(board)
   if turn_count(board) % 2 == 0
     "X"
   else
     "O"
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
  if board.detect {|i| i == nil || i == " "}
    false
  else
    true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
     true
  else
     false
   end
 end
  
def over?(board)
  if won?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if  win_combination = won?(board)
    board[win_combination.first]
  end
end
  
def play(board)
  
  while (over?(board) != true && draw?(board) != true)
    turn(board) 
  end
  
    if won?(board)
      puts "Congratulations #{winner(board)}!" 
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end

