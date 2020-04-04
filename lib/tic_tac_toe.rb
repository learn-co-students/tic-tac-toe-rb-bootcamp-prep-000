WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  bar = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts bar
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts bar
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
  index = number.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if "#{position}" == "X" || "#{position}" == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |array|
    matchesX = []
    matchesO = []
    array.each do |position|
      matchesX << position if board[position] == "X"
      matchesO << position if board[position] == "O"
    end
    if matchesX.length == 3
      return matchesX
    elsif matchesO.length == 3
      return matchesO
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board) == false
    puts nil
  else
    win = won?(board)[0]
    board[win]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
