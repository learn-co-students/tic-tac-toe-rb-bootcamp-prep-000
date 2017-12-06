WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left col
  [1,4,7],  # Middle col
  [2,5,8],  # Right col
  [0,4,8],  # Right diag
  [2,4,6],  # Left diag
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

def turn_count(board)
  count = 0
  board.each do |box|
    if box == "X" || box == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 1 ? current_player = "O" : current_player = "X"
end

def turn(board)
  #check for end of game
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

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def won?(board)
  return_value = nil
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    if (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X")
      return_value = win_combination
    elsif (board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
      return_value = win_combination
    end
  end
  return_value
end

def full?(board)
  return_value = true
  board.each do |box|
    if box == " " || box == ""
      return_value = false
    end
  end
  return_value
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if !won?(board)
    nil
  else
    board[won?(board)[0]]
  end
end
