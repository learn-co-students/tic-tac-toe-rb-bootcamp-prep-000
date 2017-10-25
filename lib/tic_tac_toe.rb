WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts "-----------"
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  (!position_taken?(board, index) && (index.between?(0, 8))) ?
  true : false
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
  else
    puts "Please enter 1-9:"
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |character|
    (character == "X" || character == "O")?
      turn += 1 : turn
  end
  turn
end

def current_player(board)
  (turn_count(board).even?)?
   "X" : "O"
end

def won?(board)
 WIN_COMBINATIONS.each do |combos|
  if ((board[combos[0]] == "X" && board[combos[1]] == "X" && board[combos[2]] == "X") ||
    (board[combos[0]] == "O" && board[combos[1]] == "O" && board[combos[2]] == "O"))
     return combos
   end
 end
 return false
end

def full?(board)
  board.none? {|characters| characters == " "}
end

def draw?(board)
  if full?(board)
     if won?(board)
       return false
     else
       return true
     end
   else
    return false
  end
end

def over?(board)
  (draw?(board) || won?(board) || full?(board))?
  true : false
end

def winner(board)
  if won?(board)
    (board[won?(board)[0]] == "X")?
    "X" : "O"
  else
    nil
  end
end

def play(board)
  until (over?(board)) do
   puts "Please enter 1-9:"
   turn(board)
 end
   if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
