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
  
def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1 
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  elsif (board[index] == "X" || board[index] == "O")
    return true
  end
end

def valid_move?(board, index)
  if (index.between?(0, 8) && !(position_taken?(board, index)))
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  character = current_player(board)
  if (valid_move?(board, index))
    move(board, index, character)
    display_board(board)
  else
    puts "Try again!"
    turn(board)
  end
end

def turn_count(board)
  counter = 0 
  board.each do |position|
    if (position == "X" || position == "O")
      counter += 1 
    end
  end
  return counter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else 
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
  win_index_1 = win_combo[0]
  win_index_2 = win_combo[1]
  win_index_3 = win_combo[2]
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2]
  position_3 = board[win_index_3] 
  if (position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O")
    return win_combo
  end
  end
  false
end

def full?(board)
  if (board.all? {|i| i=="X" || i=="O"})
    return true
  end
  false
end
  
def draw?(board)
  if (full?(board) && won?(board) == false)
    return true
  end
end
  
def over?(board)
  if (full?(board) || draw?(board) || won?(board))
    return true
  end
end
    
def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
  win_index_1 = win_combo[0]
  win_index_2 = win_combo[1]
  win_index_3 = win_combo[2]
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2]
  position_3 = board[win_index_3] 
  if (position_1 == "X" && position_2 == "X" && position_3 == "X")
    return "X"
  elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
    return "O"
  end
  end
  nil
end

def play(board)
  until (over?(board)) do
    turn(board)
  end
  if (draw?(board))
    puts "Cat's Game!"
    return
  end
  if (winner(board) == "X")
    puts "Congratulations X!"
    return 
  elsif (winner(board) == "O")
    puts "Congratulations O!"
    return 
  end
end