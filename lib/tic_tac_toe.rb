WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def xwin(array)
  array.all? { |d| d == "X"}
end

def owin(array)
  array.all? { |d| d == "O"}
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn_count(board)
  counter = 0
  board.each do |place|
    if place != "" && place !=" "
      counter +=1
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
  WIN_COMBINATIONS.each do |i|
    result = []
    i.each do |j|
      result << board[j]
    end
    if owin(result)
      return i
    elsif xwin(result)
      return i
    end
    end
  return false
end

def full?(board)
  board.none? { |f| f == " " }
end

def draw?(board)
  a = 0
  b = 0
  if full?(board)
    a += 1
  end
  if won?(board)
    b +=1
    return false
  end
  if a == 1 && b = 0
      return true
  end
    return false
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  end
  return false
end

def winner(board)
  WIN_COMBINATIONS.each do |i|
    result = []
    i.each do |j|
      result << board[j]
    end
    if owin(result)
      return "O"
    elsif xwin(result)
      return "X"
    end
    end
  return nil
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

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    c = winner(board)
    puts "Congratulations #{c}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
