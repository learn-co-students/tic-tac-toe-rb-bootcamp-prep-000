WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Diagonal left to right
  [2,4,6]  # Diagonal right to left
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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
  puts input
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
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) %2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X"  && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O"  && position_2 == "O" && position_3 == "O")
       return win_combination # return the win_combination indexes that won.
    end
  end
end

def full?(board)
  if board.detect do |index|
    index == " " || index == "" || index == nil
  end
    false
  else
    true
  end
end

def draw?(board)
  won?(board) != nil ? false : full?(board) == true ? true : false
end

def empty?(board)
  if board[0] == " " && board[1] == " " && board[2] == " " && board[3] == " " && board[4] == " " && board[5] == " " &&
     board[6] == " " && board[7] == " " && board[8] == " "
    true
  end
end

def over?(board)
  if won?(board) != nil || draw?(board) == true || full?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == nil
    nil
  else
    i = won?(board).first
    board[i]
  end
end

def play(board)
  until over?(board) == true
  turn(board)
  if won?(board) != nil
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats game"
  end
  end
end
