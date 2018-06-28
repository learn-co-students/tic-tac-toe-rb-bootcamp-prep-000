WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
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

def move(board, index, char)
  board[index] = char
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
  char = current_player(board)
  puts "Please choose a char:"
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|char| char == "X" || char == "O"}
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else 
    return "O"
  end
end


def draw?(board)
  !won?(board) && full?(board)
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] && position_taken?(board, win_combo[0])
  end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos == "O"
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win_combo = won?(board) #resulting array from #won? is set to win_combo variable
  if won?(board)
    return board[win_combo[0]]
  end
end

def play(board)
until over?(board)
    turn(board)
  end
  if won?(board) && winner(board) == "X"
    puts "Congratulations X!"
    elsif won?(board) && winner(board) == "O"
    puts "Congratulations O!"
    elsif draw?(board)
    puts "Cat's Game!"
  end
end
