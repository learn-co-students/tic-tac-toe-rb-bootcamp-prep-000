def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
  ]
  
 def display_board(x)
  puts " #{x[0]} | #{x[1]} | #{x[2]} ","-----------"," #{x[3]} | #{x[4]} | #{x[5]} ","-----------"," #{x[6]} | #{x[7]} | #{x[8]} "
end

def input_to_index(input)
  num = input.to_i
  num - 1
end 

def move(array, index, value)
  array[index] = value
end 

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
    
  else 
    false
  end 
end


def position_taken?(array, index)
  if array[index] == " " || array[index] == "" || array[index] == nil
      false
      
  else 
    true
  end 
end

def turn(board) 
  puts "Please select 1-9"
  x = gets.strip
  input = input_to_index(x)
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end 
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1 
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end 
  
def won?(board)
      
  if board[0] == "X" && board[1] == "X" && board[2] == "X"
    WIN_COMBINATIONS[0]
   
  elsif board[0] == "O" && board[1] == "O" && board[2] == "O"
    WIN_COMBINATIONS[0]
    
  elsif board[3] == "X" && board[4] == "X" && board[5] == "X"
    WIN_COMBINATIONS[1]
    
  elsif board[3] == "O" && board[4] == "O" && board[5] == "O"
    WIN_COMBINATIONS[1]
    
  elsif board[6] == "X" && board[7] == "X" && board[8] == "X"
    WIN_COMBINATIONS[2]
    
  elsif board[6] == "O" && board[7] == "O" && board[8] == "O"
    WIN_COMBINATIONS[2]
    
  elsif board[0] == "X" && board[3] == "X" && board[6] == "X"
    WIN_COMBINATIONS[3]
    
  elsif board[0] == "O" && board[3] == "O" && board[6] == "O"
    WIN_COMBINATIONS[3]
    
  elsif board[1] == "X" && board[4] == "X" && board[7] == "X"
    WIN_COMBINATIONS[4]
    
  elsif board[1] == "O" && board[4] == "O" && board[7] == "O"
    WIN_COMBINATIONS[4]
    
  elsif board[2] == "X" && board[5] == "X" && board[8] == "X"
    WIN_COMBINATIONS[5]
    
  elsif board[2] == "O" && board[5] == "O" && board[8] == "O"
    WIN_COMBINATIONS[5]
    
  elsif board[2] == "X" && board[4] == "X" && board[6] == "X"
    WIN_COMBINATIONS[6]
    
  elsif board[2] == "O" && board[4] == "O" && board[6] == "O"
    WIN_COMBINATIONS[6]
    
  elsif board[0] == "X" && board[4] == "X" && board[8] == "X"
    WIN_COMBINATIONS[7]
    
  elsif board[0] == "O" && board[4] == "O" && board[8] == "O"
    WIN_COMBINATIONS[7]
    
  else
    false
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end 
end

def draw?(board)
  if full?(board) && won?(board) == false
    true
  else 
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true 
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    won?(board).each do |value|
      if board[value] == "X"
        return "X"
      else
       return "O"
      end
    end
  else
    nil
  end 
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end 
end
