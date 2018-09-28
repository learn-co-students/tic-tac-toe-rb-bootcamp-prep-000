def display_board(board)
  puts " #{ board[0] } | #{ board[1] } | #{ board[2] } "
  puts "-----------"
  puts " #{ board[3] } | #{ board[4] } | #{ board[5] } "
  puts "-----------"
  puts " #{ board[6] } | #{ board[7] } | #{ board[8] } "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def player_move(board, index, current_player)
  board[index] = current_player
end

=begin
def turn_count(board)
  counter = 0 
  board.each do |index| 
    if 
      index == "X" || index == "O"
      counter += 1
    end
  end
  counter
end
=end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  if 
    turn_count(board) % 2 == 0
      "X"
  else
      "O"
  end
end

=begin
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
=end

WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # diagonal 0-8
  [2, 4, 6]# diagonal 2-6
  ]
  
def valid_move?(board, index)
    index.between?(0, 8) && !position_taken?(board, index)
end
  
def position_taken?(board, index)
  if
    board[index] == "X" || board[index] == "O"
    return true 
  elsif
    board[index] == "" || board[index] == " " || board[index] == nil 
    return false
  end
end 

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if 
    valid_move?(board, index)
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while
    !over?(board)
    turn(board)
  end
  if 
    won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif
    draw?(board)
    puts "Cat's Game!"
  end
end
  
def won?(board)
  WIN_COMBINATIONS.find do |index|
    board[index[0]] == board[index[1]] &&
    board[index[1]] == board[index[2]] &&
    position_taken?(board, index[0])
  end 
end 

def full?(board) 
  if board.find {|index| index == "" || index == " " || index == nil}
  false
else 
  true
  end
end

def draw?(board)
  if won?(board)
    false
  else 
    full?(board)
  end
end

def over?(board)
  if won?(board) ||  draw?(board)
    true
  else 
    false    
  end
end

def winner(board)
  if
    winner = won?(board)
    (board)[winner[0]]
  else
    nil
  end
end