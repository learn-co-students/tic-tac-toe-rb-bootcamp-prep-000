WIN_COMBINATIONS = [
[0,1,2],   # Top row
[3,4,5],   # Middle row
[6,7,8],   # Bottom row
[0,3,6],   # Left column
[1,4,7],   # Middle column
[2,5,8],   # Right column
[0,4,8],   # diagonals 1
[2,4,6]    # diagonals 2
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("-----------")
  puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("-----------")
  puts (" #{board[6]} | #{board[7]} | #{board[8]} ")
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

def current_player(board)
  player_x = 0
  player_y = 0
  board.each do |fu|
    if fu == "X"
      player_x += 1
    elsif fu == "O"
      player_y += 1
    end
    if
      player_y >= player_x
      return "X"
    else
      return "O"
    end
  end


def turn(board)
  puts "Please enter 1-9:"
 index = input_to_index(gets.strip)
 current_player = current_player(board)
if  valid_move?(board, index) == true
  move(board, index, current_player)
else
  turn(board)
end
return display_board(board)
end
end

def turn_count(board)
      counter = 0
  board.each do |player|
    if player == "X" || player == "O"
      counter += 1
    else
      counter += 0
    end
  end
      return counter
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw? (board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over? (board)
  if won?(board) == true || draw?(board) == true || full?(board)
    return true
  else
    return false
  end
end

def winner (board)
  no_winner_board = []
  won?(board)
  if won?(board) == false
    return no_winner_board[0]
  else
    winner = won?(board)
    return board[winner[0]]
  end
end
