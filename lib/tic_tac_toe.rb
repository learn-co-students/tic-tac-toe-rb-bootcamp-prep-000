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
  board_row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  board_row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  board_row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  board_line = "-----------"
  puts board_row1
  puts board_line
  puts board_row2
  puts board_line
  puts board_row3
end

def input_to_index(piece)
  index = piece.to_i
  index = index - 1
  return index
end

def move(array, piece, char)
  array[piece] = char
  return array
end

def position_taken? (array, char)
  if array[char] == " " || array[char] == "" || array[char] == nil
    false
  elsif array[char] == "X" || array[char] == "O"
    true
  else
    true
  end
end

def valid_move?(array, spot)

  if spot.between?(0,8) && !position_taken?(array, spot)
    true
  else
    false
  end

end

def turn(board)
  puts "Please enter 1-9:"
  spot = gets.strip
  index = input_to_index(spot)
  char = current_player(board)
  if valid_move?(board, index) == false
    turn(board)
  else move(board, index, char)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if !(turn == "" || turn == " ")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turns = turn_count(board)
  mod = turns % 2
  if !(mod == 0)
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win|
    board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]] && position_taken?(board, win[0])
  end
end

def full?(board)
  board.all? do |piece|
    piece == "X" || piece == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win = won?(board)
    board[win.first]
  end
end

def play(board)
  display_board(board)
  until over?(board) do
    turn(board)
  end
  if !draw?(board) && winner(board) == "X"
    puts "Congratulations X!"
  elsif !draw?(board) && winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end
end
