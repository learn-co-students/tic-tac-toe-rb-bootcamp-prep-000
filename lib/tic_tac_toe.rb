
WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
index= user_input.to_i - 1
end

def move(board, position, char)
board[position] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input= gets.strip
  index= input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, char = "X")
    display_board(board)
  else
      turn(board)
  end
end

def turn_count(board)
    counter = 0
    board.each do |marker|
      if marker == "X" || marker == "O"
      counter += 1
      end
    end
    return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |win_combination|
win_index_1 = win_combination[0]
win_index_2 = win_combination[1]
win_index_3 = win_combination[2]
position_1 = board[win_index_1]
position_2 = board[win_index_2]
position_3 = board[win_index_3]
if position_1 == "X" && position_2 == "X" && position_3 == "X"
  return win_combination
elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? {|player| player != " "}
end

def draw?(board)
if won?(board) == false && full?(board) == true
  return true
elsif won?(board) == false && full?(board) == false
  return false
else
  return false
  end
end

def over?(board)
if won?(board) != false || draw?(board) == true || full?(board) == true
  return true
  end
end

def winner(board)
if won?(board) != false
  win_combination = won?(board)
end
if won?(board) != false && board[win_combination[0]] == "X"
  return "X"
elsif won?(board) != false && board[win_combination[0]] == "O"
  return "O"
else
  return nil
end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
