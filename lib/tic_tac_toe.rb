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
#helper_method  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


#helper_method
def input_to_index(user_input)
  user_input.to_i - 1
end
#helper_method
def move(board, index, current_player)
  board[index] = current_player
end
#helper_method
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
#helper_method
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# def position_taken?(board, location)
#   board[location] != " " && board[location] != ""
# end

def turn_count(board)
  turns = 0 
    board.each do |element|
      if element != " "
        turns += 1
    end 
  end 
  turns 
end 
#helper_method
def current_player(board)
  if turn_count(board).even? 
    return "X"
  end 
  return "O"
end 

#helper_method
def won?(board)
  WIN_COMBINATIONS.detect do |win_array|
      board[win_array[0]] == board[win_array[1]] && board[win_array[1]] == board[win_array[2]] && position_taken?(board,win_array[0])
    end 
end 

#helper_method
def full?(board)
  board.all? {|element| element == "X" || element == "O" } 
end 
#helper_method
def draw?(board)
  full?(board) && !won?(board)
end 

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true 
  end 
end 

def winner(board)
  WIN_COMBINATIONS.each do |win_array|
    if win_array.all? {|index| board[index] == "X"}
      return "X"
    elsif win_array.all? {|index| board[index] == "O"}
      return "O"
    end 
  end 
   nil  
end

def play(board)
  until over?(board) 
    turn(board)
  end 
    if winner(board) == "X" 
      puts "Congratulations X!"
    elsif winner(board) == "O" 
      puts "Congratulations O!" 
    elsif winner(board) == nil 
      puts "Cat's Game!"
    end 
end 

