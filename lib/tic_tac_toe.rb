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

def move(array, index, char)
  array[index] = char
end

def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == nil
    false
  else board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0, 8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
   turn_count(board).even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all? { |index| board[index] == "X"} || combo.all? { |index| board[index] == "O"}
      return combo
    end
  end
  return nil
end

def full?(board)
  board.all? { |index| index == "X" || index == "O"  }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
   return board[won?(board)[0]]
 else
   nil
 end
end

def play(board)
 until over?(board)
   turn(board)
 end
 if winner(board) == "X"
   puts "Congratulations X!"
 elsif winner(board) == "O"
   puts "Congratulations O!"
 else
   puts "Cat's Game!"
 end
end
