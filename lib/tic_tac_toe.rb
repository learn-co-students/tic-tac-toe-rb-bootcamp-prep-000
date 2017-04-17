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
  vert_divider = "|"
  horiz_divider = "-----------"
  cell_1 = " #{board[0]} "
  cell_2 = " #{board[1]} "
  cell_3 = " #{board[2]} "
  cell_4 = " #{board[3]} "
  cell_5 = " #{board[4]} "
  cell_6 = " #{board[5]} "
  cell_7 = " #{board[6]} "
  cell_8 = " #{board[7]} "
  cell_9 = " #{board[8]} "
  puts "#{cell_1 + vert_divider + cell_2 + vert_divider + cell_3}"
  puts horiz_divider
  puts "#{cell_4 + vert_divider + cell_5 + vert_divider + cell_6}"
  puts horiz_divider
  puts "#{cell_7 + vert_divider + cell_8 + vert_divider + cell_9}"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
  display_board(board)
end

def valid_move?(board, index)
index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  board[index] != " "
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  filled = board.select{|token| token == "X" || token == "O"}
  filled.length
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def current_player(board)
  current = nil
  if turn_count(board).odd?
    current = "O"
  elsif turn_count(board).even?
    current = "X"
  end
  return current
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
    if draw?(board)
      puts "Cats Game!"
    elsif won?(board) && winner(board) == "X"
      puts "Congratulations X!"
    elsif won?(board) && winner(board) == "O"
      puts "Congratulations O!"
  end
end
