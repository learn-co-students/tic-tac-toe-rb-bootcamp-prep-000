WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Last row
  [0,3,6], # First Vertical Row
  [1,4,7], # Second Vertical Row
  [2,5,8], # Third Vertical Row
  [0,4,8], # \ Diagonal
  [2,4,6], # / Diagonal
]

def display_board(board)
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
  if(board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  elsif(board[index] == "X" || board[index] == "O" )
    return true
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if(valid_move?(board, index))
    move(board,index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |element|
    if(element == "X" || element == "O" )
      turns+= 1
    end
  end
  return turns
end

def current_player(board)
  (turn_count(board).even?) ? "X": "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    !!(position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
  end
end

def full?(board)
  board.all? do |element|
    element == "X" || element == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  !!(won?(board) || full?(board) || draw?(board))
end

def winner(board)
  !!won?(board)? board[won?(board)[0]]: won?(board)  # where won?(board)[0] -> win_combination_array[0]
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if(!!winner(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board))
    puts "Cat's Game!"
  end
end
