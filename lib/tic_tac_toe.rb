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

def display_board(board)
  
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
    
  else
    return false
  end
  
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
  return false
else 
  return true
  end
end

def input_to_index(input)
 index = input.to_i - 1
 return index
 end


def move(board, index, value)
  board[index] = value
end


def turn_count(board)
  
  counter = 0
  board.each do |turnCount|
    if turnCount == "X" || turnCount == "O"
      counter += 1
    end
  end
  
  return counter
end

def turn(board)
  
    puts("Please enter 1-9:")
    input = gets.strip
    index = input_to_index(input)
 
   if !valid_move?(board, index)
     puts "please enter a valid input"
     turn(board)
     
  else
    value = current_player(board)
     move(board, index, value)
     display_board(board)
     
   end
 end

def current_player(board)
  
  if turn_count(board) == 0
    return "X"
  
  elsif turn_count(board) % 2 == 0
  return "X"
  
else 
  return "O"
 
end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combinations|
    
    win_index_1 = win_combinations[0]
    win_index_2 = win_combinations[1]
    win_index_3 = win_combinations[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X"  && position_3 == "X"
      return win_combinations
      
    elsif position_1 == "O" && position_2 == "O"  && position_3 == "O"
      return win_combinations
    end
  end
  return false
end



def full?(board)
  fullArray = []
  
  board.each do |is_board_full|
    
  if is_board_full == "X" || is_board_full == "O"
      fullArray.push (is_board_full)
      
    end
  end
  
  if fullArray.length == 9
    return true
  else
    return false
  end
end


def draw?(board)
  
  if full?(board) == true && won?(board) == false
    return true
    
  else 
    return false
  end
end


def over?(board)
  
  if draw?(board) == true
    return true
  
  elsif won?(board) != false
    return true
    
  elsif full?(board) == true 
  return true
  
else 
  return false
 
  end
end



def winner(board)
  
  if won?(board) != false
  win_index = won?(board)
  winning_letter = board[win_index[0]]
  return winning_letter
  
  end
end

def play(board)
  
  while over?(board) != true do
    turn(board)
    
    
  
    end
    if won?(board) != false
      winning_letter = winner(board)
       puts "Congratulations " +  winning_letter + "!"
   
    elsif draw?(board) == true
     puts "Cat's Game!"
  end
end
    
