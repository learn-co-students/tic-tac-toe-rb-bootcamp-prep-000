# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [ 
[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], 
[0, 4, 8], [2, 4, 6]]

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

def move(board, indx, player)
  board[indx] = player
end 

def valid_move?(board, indx)
  if position_taken?(board, indx)
    false
  elsif indx < 0 || indx > 8 
    false
  else 
    true 
  end 
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input_indx = input_to_index(input)
  your_turn = current_player(board)
  
  if valid_move?(board, input_indx)
    move(board, input_indx, your_turn)
    display_board(board)
  else 
    turn(board)
  end
end 

def turn_count(board)
  count = 0 
  board.each do |x|
    if x == "X" || x == "O"
      count = count + 1 
    end 
  end 
  count 
end 

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else 
    return "O"
  end 
end

def won?(board)
  
  WIN_COMBINATIONS.find do |position|
    board[position[0]] == board[position[1]] && board[position[1]] == board[position[2]] && position_taken?(board, position[0])
    end 
end 

def full?(board)
   board.all? { |x| x != " " || x == nil  }
end 

def draw?(board)
  
  if won?(board) == nil && full?(board) == true 
    true 
  else 
    false 
  end 
end 

def over?(board)
  won?(board) || draw?(board) || full?(board) ? true : false 

end 

def winner(board) 
   if won?(board) != nil 
     board[won?(board)[0]]
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
