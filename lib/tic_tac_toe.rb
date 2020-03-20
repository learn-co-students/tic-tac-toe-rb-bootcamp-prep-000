WIN_COMBINATIONS = [
  [0,1,2], # Top row 
  [3,4,5], # Middle row
  [6,7,8], # Bottom row 
  [2,5,8], # all right 
  [1,4,7], # all middle 
  [0,3,6], # all left 
  [0,4,8], # diagonal left 
  [2,4,6] # diagonal right 
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

def input_to_index(input) 
  input.to_i - 1 
end 

def move(board, index, player)
  # here we se the third argument to player and not current_player
  # due to the method we made below 
  # we originally made a default argument of "X"
  # but no longer needed with current_player method made
  # we use the current_player method when using the method turn 
  # not used in the original method due to testing issues.
  board[index] = player
end 

def position_taken?(board, index)
  !(board[index] == " " || board[index] == nil || board[index] == "")
end 

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index)
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
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter += 1 
    end 
  end 
  counter
end 

def current_player(board)
  turn_count(board).even? ? "X" : "O" 
end 

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination| 
    board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0])
  end 
end 

def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end 

def draw?(board)
  !won?(board) && full?(board)
end 

def over?(board)
  won?(board) || draw?(board) || full?(board)
end 

def winner(board)
  if winning_combination = won?(board)
    board[winning_combination.first]
  end 
end 

def play(board)
  turn(board) until over?(board) 
  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end 
