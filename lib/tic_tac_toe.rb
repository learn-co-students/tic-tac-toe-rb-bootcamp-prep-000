WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
  ]
  
def display_board(board)
puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
puts ("-----------")
puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
puts ("-----------")
puts (" #{board[6]} | #{board[7]} | #{board[8]} ")
end

def input_to_index(number)
  number = number.to_i
  number = number - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
if    board[index]==" " || board[index]=="" || board[index]==nil
false 
elsif board[index] == "" 
  true 
else 
  true 
end
end

def valid_move?(board, index)
  if position_taken?(board, index)==true
    false
  elsif index.to_i > 9 || index.to_i < 0
    false
  else 
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip.to_i - 1
  input_to_index(number)
  if valid_move?(board, number) == true
    move(board, number, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(array)
counter = 0
array.each do|index|
    if index == "X" || index == "O"
       counter += 1 
    end
end
counter
end

def current_player(board)
if turn_count(board).to_i % 2 == 0 
  "X"
else 
  "O"
end
end 

def won?(board)
  WIN_COMBINATIONS.each do|win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
    return win_combination
    elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
    return win_combination
    end
  end
    false 
end

def full?(board)
  board.all? do|index|
  index == "X" || index == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
end
end

def over?(board)
  if full?(board) == true
    true
  elsif won?(board) != false 
    true
  elsif draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    win_combination = won?(board)[0]
    board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) == true
    puts "Congratulations player #{winner(board)}!"
  elsif draw?(board) == true
    puts "It's a Cat's Game!"
  end



