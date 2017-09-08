WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2],
]

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

def move(array, index, value="X")
  array[index] = value
end

def position_taken?(board, index)
if board[index] == " " || board[index] == "" || board[index] == nil
return false
elsif board[index] == "X" || board[index] == "O"
  return true
end
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn(board)
puts "Please enter 1-9:"
input = gets
index = input_to_index(input)
if valid_move?(board, index)
  move(board, index, current_player(board))
  display_board(board)
else
  turn(board)

end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
counter = 0
board.each do |token|
  if token == "X" || token == "O"
    counter += 1
  end
end
return counter
end

def current_player(board)
if turn_count(board) % 2 == 0
  return "X"
else
  return "O"
end
end

def won?(board)
WIN_COMBINATIONS.detect do |win_combo|
  board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] &&
    position_taken?(board, win_combo[0])
end
end

def full?(board)
    if board.include? (" ")
      return false
    else
      return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
end

def winner(board)
if won?(board)
  board[won?(board).first]
  #think about what is being returned here??
  #if someone had won, take the board, then the index that won, then the first value of that
else
  return nil
end
end

def play(board)
while !over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat's Game!"
end
end
