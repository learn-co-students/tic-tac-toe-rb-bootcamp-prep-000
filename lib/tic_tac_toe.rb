WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row 
  [0,4,8], # Diagonal 0 
  [2,4,6], # Diagonal 2
  [0,3,6], # Left Column 
  [1,4,7], # Middle Column
  [2,5,8]  # Right Column
]
# Helper Methods
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
def move(board, index, current_player)
  board[index] = current_player
end
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
def turn_count(board)
  count = 0
  board.each { |cell|  count += 1 if cell == "X" || cell == "O"}
  return count
end 
def current_player(board)
  current_player = "O"
  current_player = "X" if turn_count(board) % 2 == 0 
  return current_player
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
def won?(board)
   WIN_COMBINATIONS.detect { |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    }
end
def full?(board)
 !board.detect { |cell| cell.nil? || cell == " " || cell == ""}
end
def draw?(board)
  if  won?(board)
    return false
  else
    return full?(board)
  end 
end 
def over?(board)
  won?(board) || draw?(board) || full?(board)
end 
def winner(board)
  won?(board)? board[won?(board)[0]] : nil
end
def play(board)
  until over?(board) do 
    turn(board)
  end
  if won?(board) 
    puts "Congratulations #{winner(board)}!"  
  elsif draw?(board)
    puts "Cat's Game!" 
  end
end 