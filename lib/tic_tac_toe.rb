board = [" "," "," "," "," "," "," "," "," "]
def play(board) 
while !over?(board)
turn(board)
end
if winner(board) == "X"
  puts "Congratulations X!"
elsif winner(board) == "O"
puts "Congratulations O!"
else 
  puts "Cat's Game!"
end
  
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

def move(board, index, value)
  board[index] = value
end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index,value)
    display_board(board)
  else
    turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end
def current_player(board)
if turn_count(board) % 2 == 0 
  return "X"
else 
  return "O"
end

end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def won?(board)
WIN_COMBINATIONS.any? do |win_combination|
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
!board.include?(" ")
end
def draw?(board)
if full?(board) && !won?(board)
true
end
end

def over?(board)
if won?(board) || draw?(board) || full?(board)
  true
end

end
def winner(board)
if won?(board)
winning_combo = won?(board)
winning_value = winning_combo[0]
token = board[winning_value]
return token
else
  nil
end
end
