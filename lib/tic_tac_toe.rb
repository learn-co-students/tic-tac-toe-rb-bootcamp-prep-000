WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  divider = "-----------"
  #row = "#{cell}|#{cell}|#{cell}\n#{divider}\n#{cell}|#{cell}|#{cell}\n#{divider}\n#{cell}|#{cell}|#{cell}"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "#{divider}"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "#{divider}"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(str)
  str.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board,index)
  if index.between?(0, 8) && !(position_taken?(board,index))
      true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  response = gets.chomp
  index = input_to_index(response)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |move|
    if move == "X" || move == "O"
    turns += 1
  end
  end
  turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
    end
    false
end


def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
if full?(board) && !won?(board)
     true
  else
    false
  end
 end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  #won? returns the winning combo. this is why we can access it like an array.
 if won?(board)
    board[won?(board)[0]]
  else
   nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif
    puts "Cats Game!"
  end
end
