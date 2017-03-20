WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, char  )
  board[index] = char



end

def position_taken?(board, index)

if board[index] == "" || board[index] == " " || board[index] == nil
  return false
elsif board[index] == "X" || board[index] == "O"
  return true
end
end

def valid_move?(board, index)
  # if the index is between 0 and 8 and the position is not taken, return true
  if index.between?(0, 8) && !position_taken?(board,index)
    return true
    # otherwise return false
  else
    return false
  end
end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip # will return a string
  index = input_to_index(input) # input is the data being passed to user_input
  if valid_move?(board, index)
    move(board, index,  current_player(board))

    display_board(board)
  else
    puts "Invalid move"
    display_board(board)
    turn(board)
  end

end

def turn_count(board)
  counter = 0
 board.each{|el| counter+=1 if el=="X" || el=="O"}

 return counter

end

def current_player(board)
if turn_count(board)%2 == 0
  return "X"
else
  return "O"
end
end

def won?(board)
WIN_COMBINATIONS.any? do |combo|

  if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"

      return combo
  elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
    return combo
  else false
end
  end
end

def full?(board)
  board.all? do |taken|
  taken != " "
end
end

def draw?(board)
 !won?(board) && full?(board) == true
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
if won?(board)
won?(board).all? do |wins|
  if board[wins] == "X"
    return "X"
  elsif  board[wins] == "O"
    return "O"
  else
  end
end
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
elsif draw?(board) == true
  puts "Cats Game!"
else
end
end
