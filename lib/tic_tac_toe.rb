def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7 ,8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def input_to_index(input)
input.to_i - 1
end

def move(board, index, value)
board[index] = value
end

def position_taken?(board, index)
if board[index] == " " || board[index] == "" || board[index] == nil
false
elsif board[index] == "X" || board[index] == "O"
true
end
end

def valid_move?(board, index)
index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
puts "Please enter 1-9:"
user_input = gets.strip
index = input_to_index(user_input)
if !valid_move?(board, index) == true
  turn(board)
else
  move(board, index, current_player(board))
end
display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i != " "
  count +=1
    end
  end
count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
