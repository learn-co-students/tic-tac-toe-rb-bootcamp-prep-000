WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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
    display_board(board)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
board.each do |position|
  if position == "X" || position == "O"
    turns +=1
  end
end
turns
end


def current_player(board)
  turn_count(board)
  if turn_count(board) % 2 == 0
    "X"
  else turn_count(board) % 2 == 1
    "O"
end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
    return combo
  elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
    return combo
  end
  end
  return false
end

def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
  true
else
  false
end
end

def over?(board)
  if won?(board) || draw?(board)
    true
else
  false
end
end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
    return "X"
  elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
    return "O"
  end
  end
  return nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end

  #counter = 0
#while counter < 9
  #counter += 1
  #turn(board)
#end
