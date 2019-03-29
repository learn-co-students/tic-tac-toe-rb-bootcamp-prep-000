WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Lower row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # top-left to bottom-right diagonal
  [2,4,6]  # top-right to bottom-left diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def input_to_index(user_input)
  converted_input = user_input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(array, index_number)
  if array[index_number] == " " || array[index_number] == "" || array[index_number] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0 
  board.each do |element|
    if element == "X" || element == "O"
    counter += 1 
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board) 
  WIN_COMBINATIONS.each do |win_combination| 
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" || board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return win_combination # return winning combo.
    end 
  end 
    return false # return false if there is no win combo present in board.
end

def full?(board)
  board.all? { |element| element != " " }
end

def draw?(board)
  if full?(board) && !won?(board)
    return true 
  else
  # elsif (!won?(board) && !full?(board)) || won?(board)
    return false 
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true 
  end
end

def winner(board)
   if won?(board)
      return board[won?(board)[0]] # return first element of winning trio.
   end
end

def play(board)
  until over?(board) 
    turn(board)
  end 
  if won?(board) 
    puts "Congratulations #{winner(board)}!" 
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end