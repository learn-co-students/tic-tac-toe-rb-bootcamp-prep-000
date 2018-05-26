def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0, 8)
    true
  else 
    false
  end
end

def position_taken?(board,index)
  if board[index] == " "
    false
    elsif board[index] == ""
    false
    elsif board[index] == nil
    false
    elsif board[index] == "X"
    true
    elsif board[index] == "O"
    true
  else
      nil
end
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board,index,user_input)
  board[index] = user_input
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board,index) == true
  move(board,index,current_player(board))
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
  puts counter
  end
end
counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 || turn_count(board) == 0
    return "X"
  else
    return "O"
  end
end

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
  
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# def won?(board)
#   WIN_COMBINATIONS.each do |win_combination|
#     win_index_1 = win_combination[0]
#     win_index_2 = win_combination[1]
#     win_index_3 = win_combination[2]
    
#     # load the value of the board at each win_index
#     position_1 = board[win_index_1] # board[0]
#     position_2 = board[win_index_2] # board[1]
#     position_3 = board[win_index_3] # board[2]
#     if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
#       (position_1 == "O" && position_2 == "O" && position_3 == "O")
#       return win_combination
#     end
#   end
#   return false
# end

def full?(board)
  board.all? { |index| index == "X" || index == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  name = winner(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{name}!"
  elsif draw?(board)
    puts "Cat's Game!"
 end 
end