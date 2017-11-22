board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, x)
  board[index] = x
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input - 1
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  counter = 0
  while counter < 9
    turn(board)
    counter += 1
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  counter = 0
  board.each do |place|
    if (place == " ")
      counter == counter
    else
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) == 0
    return "X"
  elsif turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |i|
    first = i[0]
    second = i[1]
    third = i[2]
    if board[first] == "X" && board[second] == "X" && board[third] == "X"
      winner = "X"
      return i
    elsif board[first] == "O" && board[second] == "O" && board[third] == "O"
      winner = "O"
      return i
    end
  end
  return false
end

def full?(board)
  if board.include?(" " || "")
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    return true
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  x_win = 0
  o_win = 0
  board.each do |i|
    if i == "X"
      x_win += 1
    elsif i == "O"
      o_win += 1
    end
  end

  if x_win > o_win
    return "X"
  elsif o_win > x_win
    return "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top Horizontal
  [3,4,5], # Middle Horizontal
  [6,7,8], # Bottom Horizontal
  [0,3,6], # Left Vertical
  [1,4,7], # Middle Vertical
  [2,5,8], # Right Vertical
  [0,4,8], # L to R Diag
  [2,4,6]  # R to L Diag
]
