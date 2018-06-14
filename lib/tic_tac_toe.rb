def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  position = user_input.to_i - 1
end

def move(board, position, current_player)
board[position] = current_player
end

def valid_move?(board, position)
if !position_taken?(board, position) && (position).between?(0, 8)
  return true
else return false
end
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], #top_row_win
  [3,4,5], #middle_row_win
  [6,7,8], #bottom_row_win
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_position_1 = win_combination[0]
    win_position_2 = win_combination[1]
    win_position_3 = win_combination[2]

    position_1 = board[win_position_1]
    position_2 = board[win_position_2]
    position_3 = board[win_position_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
else false
    end
  end
end

def over?(board)
if draw?(board) || won?(board)
  return true
else return false
  end
end

def full?(board)
  if board.detect {|i| i == " " || i == nil || i == ""}
    return false
  else true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end

def turn_count(board)
  counter = 0
  board.each do |i|
  if i == "X" || i == "O"
  counter += 1
  end
end
counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
until valid_move?(board, position) == true
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
  turn(board)
end
display_board(board)
end

def play(board)
  until over?(board) == true
    current_player(board)
    turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board) == true
  puts "Cat's Game!"
  end
end
