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
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, character)
board[index] = character
end

def position_taken?(board, index)
  if board[index] == !("" || " ")
    false
  elsif (board[index] == "X") || (board[index] == "O")
    true
  else
    false
end
end

def valid_move?(board, index)
  if (index.between?(0, 8)) && (position_taken?(board, index) == false)
    true
  elsif (position_taken?(board, index) == true)
    false
  else index < 8
   false
end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, character="X")
    display_board(board)
else
    turn(board)
end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if (space == "X" || space == "O")
      counter = counter += 1
    else
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

 def won?(board)
 WIN_COMBINATIONS.each do | win_combination |
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

   position_1 = board[win_index_1]
   position_2 = board[win_index_2]
   position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
     return true
   elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return true
  else
    false
 end
 end
 return false
 end

 def full?(board)
 board.all?{|space| space if space == "X" || space == "O" }
 end

 def draw?(board)
 	!won?(board) && full?(board)
 end

 def over?(board)
 won?(board) == true || draw?(board) == true || full?(board) == true
 end


 def winner(board)
 WIN_COMBINATIONS.each do | win_combination |
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
   return "X"
 elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  return "O"
 else
  false
 end
 end
 won?(board) == false
 return nil
 end

 def play(board)
input = gets.strip
until over?(board) == true
  turn(board)
end
if won?(board) == true
  if winner(board) == "X"
  puts "Congratulations X!"
  else winner(board) == "O"
  puts "Congratulations O!"
end
else draw?(board) == true
  puts "Cats Game!"
end
end
