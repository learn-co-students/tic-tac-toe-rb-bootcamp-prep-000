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

def turn_count(board)
  count = 0
  board.each do |space|
    if space != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

WIN_COMBINATIONS = [
 [0,1,2], # Top row
 [3,4,5], # Middle row
 [6,7,8], # Bottom row
 [0,3,6], # First column
 [1,4,7], # Second column
 [2,5,8], # Third column
 [0,4,8], # Left diagonal
 [2,4,6]  # Right diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == "X" && board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] 
      return win_combo 
    elsif
      board[win_combo[0]] == "O" && board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] 
      return win_combo 
    end
  end
  return nil
end

def full?(board)    
  board.all?{ |x| x == "X" || x == "O" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win_combo = won?(board)
  
  if(win_combo)
    board[win_combo[0]]
  end
end
