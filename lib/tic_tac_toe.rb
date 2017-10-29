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
  rows = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts rows
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts rows
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(string)
  string.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  board[index]!=" "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "please enter 1-9"
  input = gets.strip
  num = input_to_index(input)
  if valid_move?(board, num)
    move(board, num, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |value|
    if value != " "
      count+=1
    end
  end
  count
end

def current_player(board)
  if (turn_count(board).even? || turn_count(board) == 0)
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo_array|
    first_index = combo_array[0]
    second_index = combo_array[1]
    third_index = combo_array[2]

    arr = [board[first_index], board[second_index], board[third_index]]
    all_x = arr.all? do |value|
      value == "X"
    end
    all_o = arr.all? do |value|
      value == "O"
    end

    if all_x || all_o
      return true
    end
  end
  return false
end

def full?(board)
  board.none?{|i| i==" "}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |combo_array|
    first_index = combo_array[0]
    second_index = combo_array[1]
    third_index = combo_array[2]

    arr = [board[first_index], board[second_index], board[third_index]]
    all_x = arr.all? do |value|
      value == "X"
    end
    all_o = arr.all? do |value|
      value == "O"
    end

    if all_x
      return "X"
    end

    if all_o
      return "O"
    end
  end
return nil
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
