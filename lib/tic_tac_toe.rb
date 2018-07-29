
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Columns
  [1,4,7],
  [2,5,8],
  [0,4,8], #diagonals
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

def move(board, index, player) 
  board[index] = player
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def turn_count(board)
  filled_spaces = board.select{ |pos| !(pos == nil? || pos == " ") }
  filled_spaces.length
end

def won?(board)
  WIN_COMBINATIONS.detect {|combo| wins?(combo, board)}
end

def wins?(combo, board)
  combo.all? {|pos| board[pos] == "X"} || combo.all? {|pos| board[pos] == "O"}
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  #returns false if the board is won
  if won?(board)
    return false
  #returns true if the board has not been won and is full 
  elsif full?(board)  
    return true
  #returns false if the board is not won and the board is not full
  else
    return false
  end
end

#returns true if the board has been won, is a draw, or is full
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  combo =  won?(board)
  if combo
    return board[combo[0]]
  end
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

# Define your play method below
def play(board)
  
  while !(over?(board))
    turn(board)
  end
  
  if (winner = winner(board))
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
  
end

