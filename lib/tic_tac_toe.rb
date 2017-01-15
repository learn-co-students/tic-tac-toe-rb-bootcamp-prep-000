
board = [" ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
  end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
   if board[index] == "X" || board[index] == "O"
   return true
 else
   return false
end
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if !position_taken?(board, index)
    true
  end
end
end

def position_taken?(board, index)
   board[index] != " "
end

def turn(board)
  puts "Please enter 1-9:"
  input =gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
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
  if turn_count(board).even? == true
    return "X"
  else
    return "O"
  end
end

def won? (board)
    WIN_COMBINATIONS.each do |wincombo|
  if (board[wincombo[0]]) == "X" && (board[wincombo[1]]) == "X" && (board[wincombo[2]]) == "X"
    return wincombo
  elsif (board[wincombo[0]]) == "O" && (board[wincombo[1]]) == "O" && (board[wincombo[2]]) == "O"
    return wincombo
  end
  end
    return false
end

 def full?(board)
    board.all? {|spot| spot == "X" || spot == "O"}
end


def draw?(board)
   !won?(board) && full?(board) 

end

def over?(board)
  if won?(board) != false
    return true
  elsif draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if win_combo = won?(board)
    index = win_combo[0]
    return board[index]

end
end
