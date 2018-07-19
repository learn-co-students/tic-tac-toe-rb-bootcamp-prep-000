
WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # bottom row 
    [0,4,8], # top left diagonal 
    [0,3,6], # left column 
    [1,4,7], # middle column 
    [2,5,8],  # bottom column 
    [2,4,6]  # right diagonal win 
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] != ' '
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  user_input = input_to_index(user_input)
  if valid_move?(board, user_input)
    move(board, user_input, current_player(board))
    puts display_board(board)
  else
    puts "That is an invalid entry!"
    turn(board)
  end
end


def turn_count (board)
  turn = 0
  board.each do |space|
   if space == "X" || space == "O"
    turn += 1 
   end
  end
  turn
end 

def won?(board)
  win_index = Array.new
  if board.all?{|i| i == " "}
    return false 
  elsif board[0] == "X" and board[1] == "X" and board[2] == "X"
    win_index << 0
    win_index << 1
    win_index << 2    
      return win_index
   elsif board[0] == "O" and board[1] == "O" and board[2] == "O"
    win_index << 0
    win_index << 1
    win_index << 2    
      return win_index
  
  elsif board[3] == "X" and board[4] == "X" and board[5] == "X"
    win_index << 3
    win_index << 4
    win_index << 5    
      return win_index
   elsif board[3] == "O" and board[4] == "O" and board[5] == "O"
    win_index << 3
    win_index << 4
    win_index << 5    
      return win_index
      
  elsif board[6] == "X" and board[7] == "X" and board[8] == "X"
    win_index << 6
    win_index << 7
    win_index << 8    
      return win_index
  elsif board[6] == "O" and board[7] == "O" and board[8] == "O"
    win_index << 6
    win_index << 7
    win_index << 8    
      return win_index    
      
  elsif board[0] == "X" and board[4] == "X" and board[8] == "X"
    win_index << 0
    win_index << 4
    win_index << 8    
      return win_index
  elsif board[0] == "O" and board[4] == "O" and board[8] == "O"
    win_index << 0
    win_index << 4
    win_index << 8    
      return win_index     
      
  elsif board[6] == "X" and board[4] == "X" and board[2] == "X"
    win_index << 6
    win_index << 4
    win_index << 2    
      return win_index
   elsif board[6] == "O" and board[4] == "O" and board[2] == "O"
    win_index << 6
    win_index << 4
    win_index << 2    
      return win_index     
      
  elsif board[0] == "O" and board[3] == "O" and board[6] == "O"
    win_index << 0
    win_index << 3
    win_index << 6    
      return win_index
  elsif board[0] == "X" and board[3] == "X" and board[6] == "X"
    win_index << 0
    win_index << 3
    win_index << 6    
      return win_index     
      
  elsif board[1] == "X" and board[4] == "X" and board[7] == "X"
    win_index << 1
    win_index << 4
    win_index << 7    
      return win_index     
  elsif board[1] == "O" and board[4] == "O" and board[7] == "O"
    win_index << 1
    win_index << 4
    win_index << 7    
      return win_index
 
  elsif board[2] == "X" and board[5] == "X" and board[8] == "X"
    win_index << 2
    win_index << 5
    win_index << 8    
      return win_index     
  elsif board[2] == "O" and board[5] == "O" and board[8] == "O"
    win_index << 2
    win_index << 5
    win_index << 8    
      return win_index
      
  elsif board[2] == "X" and board[4] == "X" and board[6] == "X"
    win_index << 2
    win_index << 4
    win_index << 6    
      return win_index    
  elsif board[2] == "O" and board[4] == "O" and board[6] == "O"
    win_index << 2
    win_index << 4
    win_index << 6    
      return win_index
  else
      return false 
  end
end

def full?(board)
  board.all? {|i| i != " "}
end 

def draw?(board)
  full?(board) && !won?(board)
end 

def over?(board)
  return true if draw?(board)
  return true if won?(board) && full?(board)
  return true if won?(board) && !full?(board)
  return false
end

def winner(board)
  if won?(board) && won?(board).any?{|i| board[i] == "X"}
    return "X"
  elsif won?(board) && won?(board).any?{|i| board[i] == "O"}
    return "O"
  end 
end 

def current_player (board)
  turn=turn_count(board)
  if turn.to_i.even?
    return "X"
  else 
    return "O"
  end 
end


def play (board)
    while !over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end


