

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

def input_to_index(user_input)
  user_input.to_i - 1
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
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
  board.each do |move|
    if move == "X" || move == "O"
      count += 1
  end
end
  count
end



def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    if !won?(board)
      return turn(board)
  end
end



def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  if
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]


  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3]
 # load the value of the board at win_index_2
 # load the value of the board at win_index
 if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
 position_1 == "O" && position_2 == "O" && position_3 == "O"
   return win_combination
 end
 end
else false
 end
 end

 def full?(board)
   if !board.any?{|i| i == " "}
     true
   end
 end

 def draw?(board)
  if !won?(board) && full?(board)
  return true
else return false
end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else return false
  end
end

def winner(board)
   if winning_combo = won?(board)
     return board[winning_combo.first]
end
end
end

def play(board)
until over?(board)
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
     puts "Cat's Game!"
   end
 end
